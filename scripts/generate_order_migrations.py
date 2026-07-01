#!/usr/bin/env python3
"""Generate Flyway SQL from OFBiz order-entitymodel.xml and orderseeddata.xml."""
import re
import xml.etree.ElementTree as ET
from pathlib import Path

OFBIZ_ROOT = Path(r"C:\vivek\ofbiz-framework\applications\datamodel")
ENTITY_XML = OFBIZ_ROOT / "entitydef" / "order-entitymodel.xml"
SEED_XML = OFBIZ_ROOT / "data" / "seed" / "orderseeddata.xml"
OUT_DIR = Path(r"C:\vivek\project\orders\src\main\resources\db\migration")

FIELD_SQL = {
    "id": "VARCHAR(20)",
    "id-long": "VARCHAR(60)",
    "id-vlong": "VARCHAR(250)",
    "indicator": "CHAR(1)",
    "name": "VARCHAR(100)",
    "description": "VARCHAR(255)",
    "long-varchar": "VARCHAR(255)",
    "value": "VARCHAR(255)",
    "comment": "VARCHAR(255)",
    "date-time": "TIMESTAMP",
    "date": "DATE",
    "currency-amount": "NUMERIC(18,3)",
    "currency-precise": "NUMERIC(18,6)",
    "fixed-point": "NUMERIC(18,6)",
    "numeric": "NUMERIC(20,0)",
    "floating-point": "DOUBLE",
    "very-short": "VARCHAR(10)",
    "url": "VARCHAR(2000)",
    "email": "VARCHAR(255)",
    "credit-card-number": "VARCHAR(255)",
    "credit-card-date": "VARCHAR(20)",
    "blob": "BLOB",
    "byte-array": "BLOB",
    "object": "BLOB",
}


def camel_to_snake(name: str) -> str:
    s1 = re.sub(r"(.)([A-Z][a-z]+)", r"\1_\2", name)
    return re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", s1).upper()


def table_name(entity) -> str:
    explicit = entity.get("table-name")
    if explicit:
        return explicit.upper()
    return camel_to_snake(entity.get("entity-name", "UNKNOWN"))


def sql_type(field_type: str) -> str:
    return FIELD_SQL.get(field_type, "VARCHAR(255)")


def parse_entities():
    tree = ET.parse(ENTITY_XML)
    root = tree.getroot()
    entities = []
    for entity in root.findall("entity"):
        fields = []
        for field in entity.findall("field"):
            fields.append((field.get("name"), field.get("type", "id")))
        pk = [pk.get("field") for pk in entity.findall("prim-key")]
        indexes = []
        for idx in entity.findall("index"):
            indexes.append([f.get("name") for f in idx.findall("index-field")])
        internal_fks = set()
        for rel in entity.findall("relation"):
            if rel.get("type") == "one" and rel.get("fk-name"):
                rel_entity = rel.get("rel-entity-name")
                if rel_entity:
                    internal_fks.add(rel_entity)
        entities.append({
            "name": entity.get("entity-name"),
            "table": table_name(entity),
            "fields": fields,
            "pk": pk,
            "indexes": indexes,
            "internal_fks": internal_fks,
        })
    return entities


def entity_names_set(entities):
    return {e["name"] for e in entities}


def generate_schema(entities):
    names = entity_names_set(entities)
    lines = [
        "-- OFBiz order-entitymodel.xml (100 physical entities)",
        "-- Generated schema for orders microservice",
        "",
        "-- Minimal common reference tables required by order seed data",
        "CREATE TABLE IF NOT EXISTS STATUS_TYPE (",
        "    STATUS_TYPE_ID VARCHAR(20) NOT NULL PRIMARY KEY,",
        "    PARENT_TYPE_ID VARCHAR(20),",
        "    HAS_TABLE CHAR(1),",
        "    DESCRIPTION VARCHAR(255)",
        ");",
        "",
        "CREATE TABLE IF NOT EXISTS STATUS_ITEM (",
        "    STATUS_ID VARCHAR(20) NOT NULL PRIMARY KEY,",
        "    STATUS_TYPE_ID VARCHAR(20),",
        "    STATUS_CODE VARCHAR(60),",
        "    SEQUENCE_ID VARCHAR(20),",
        "    DESCRIPTION VARCHAR(255)",
        ");",
        "",
        "CREATE TABLE IF NOT EXISTS ENUMERATION_TYPE (",
        "    ENUM_TYPE_ID VARCHAR(20) NOT NULL PRIMARY KEY,",
        "    PARENT_TYPE_ID VARCHAR(20),",
        "    HAS_TABLE CHAR(1),",
        "    DESCRIPTION VARCHAR(255)",
        ");",
        "",
        "CREATE TABLE IF NOT EXISTS ENUMERATION (",
        "    ENUM_ID VARCHAR(20) NOT NULL PRIMARY KEY,",
        "    ENUM_TYPE_ID VARCHAR(20),",
        "    ENUM_CODE VARCHAR(60),",
        "    SEQUENCE_ID VARCHAR(20),",
        "    DESCRIPTION VARCHAR(255)",
        ");",
        "",
        "CREATE TABLE IF NOT EXISTS STATUS_VALID_CHANGE (",
        "    STATUS_ID VARCHAR(20) NOT NULL,",
        "    STATUS_ID_TO VARCHAR(20) NOT NULL,",
        "    TRANSITION_NAME VARCHAR(255),",
        "    PRIMARY KEY (STATUS_ID, STATUS_ID_TO)",
        ");",
        "",
    ]

    for ent in entities:
        lines.append(f"CREATE TABLE IF NOT EXISTS {ent['table']} (")
        col_defs = []
        for fname, ftype in ent["fields"]:
            col_defs.append(f"    {camel_to_snake(fname)} {sql_type(ftype)}")
        if ent["pk"]:
            pk_cols = ", ".join(camel_to_snake(c) for c in ent["pk"])
            col_defs.append(f"    PRIMARY KEY ({pk_cols})")
        lines.append(",\n".join(col_defs))
        lines.append(");")
        lines.append("")

    # Internal FK constraints only (both tables in order model)
    lines.append("-- Internal foreign keys (order module entities only)")
    tree = ET.parse(ENTITY_XML)
    root = tree.getroot()
    added = set()
    for entity in root.findall("entity"):
        src_table = table_name(entity)
        for rel in entity.findall("relation"):
            if rel.get("type") != "one" or not rel.get("fk-name"):
                continue
            rel_entity = rel.get("rel-entity-name")
            if rel_entity not in names:
                continue
            dst_table = camel_to_snake(rel_entity)
            fk_name = rel.get("fk-name")
            if fk_name in added:
                continue
            key_maps = rel.findall("key-map")
            if not key_maps:
                continue
            src_cols = []
            dst_cols = []
            for km in key_maps:
                src = km.get("field-name")
                dst = km.get("rel-field-name", src)
                if src:
                    src_cols.append(camel_to_snake(src))
                    dst_cols.append(camel_to_snake(dst))
            if not src_cols:
                continue
            added.add(fk_name)
            lines.append(
                f"ALTER TABLE {src_table} ADD CONSTRAINT {fk_name} "
                f"FOREIGN KEY ({', '.join(src_cols)}) REFERENCES {dst_table} ({', '.join(dst_cols)});"
            )

    for ent in entities:
        for idx_fields in ent["indexes"]:
            idx_name = f"IDX_{ent['table']}_{'_'.join(camel_to_snake(f) for f in idx_fields)}"
            idx_name = idx_name[:60]
            cols = ", ".join(camel_to_snake(f) for f in idx_fields)
            lines.append(f"CREATE INDEX IF NOT EXISTS {idx_name} ON {ent['table']} ({cols});")

    return "\n".join(lines) + "\n"


def sql_literal(value: str) -> str:
    if value is None:
        return "NULL"
    return "'" + value.replace("'", "''") + "'"


def generate_seed():
    tree = ET.parse(SEED_XML)
    root = tree.getroot()
    lines = [
        "-- OFBiz orderseeddata.xml",
        "-- Reference / lookup seed data for order management",
        "",
    ]
    for child in root:
        tag = child.tag
        table = camel_to_snake(tag)
        cols = []
        vals = []
        for attr, value in child.attrib.items():
            cols.append(camel_to_snake(attr))
            vals.append(sql_literal(value))
        if not cols:
            continue
        col_sql = ", ".join(cols)
        val_sql = ", ".join(vals)
        lines.append(f"INSERT INTO {table} ({col_sql}) SELECT {val_sql}")
        lines.append(f"WHERE NOT EXISTS (SELECT 1 FROM {table} WHERE {cols[0]} = {vals[0]});")
        lines.append("")
    return "\n".join(lines) + "\n"


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    entities = parse_entities()
    schema = generate_schema(entities)
    seed = generate_seed()
    schema_path = OUT_DIR / "V1__order_schema.sql"
    seed_path = OUT_DIR / "V2__order_seed.sql"
    schema_path.write_text(schema, encoding="utf-8")
    seed_path.write_text(seed, encoding="utf-8")
    print(f"Entities: {len(entities)}")
    print(f"Wrote {schema_path} ({schema_path.stat().st_size} bytes)")
    print(f"Wrote {seed_path} ({seed_path.stat().st_size} bytes)")


if __name__ == "__main__":
    main()
