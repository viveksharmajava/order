# Generate Flyway SQL from OFBiz order entity model and seed data
$entityXml = "C:\vivek\ofbiz-framework\applications\datamodel\entitydef\order-entitymodel.xml"
$seedXml = "C:\vivek\ofbiz-framework\applications\datamodel\data\seed\orderseeddata.xml"
$outDir = "C:\vivek\project\orders\src\main\resources\db\migration"

function ConvertTo-SnakeCase([string]$name) {
    $s = [regex]::Replace($name, '(.)([A-Z][a-z]+)', '$1_$2')
    $s = [regex]::Replace($s, '([a-z0-9])([A-Z])', '$1_$2')
    return $s.ToUpper()
}

$fieldMap = @{
    'id'='VARCHAR(20)'; 'id-long'='VARCHAR(60)'; 'id-vlong'='VARCHAR(250)'
    'indicator'='CHAR(1)'; 'name'='VARCHAR(100)'; 'description'='VARCHAR(255)'
    'long-varchar'='VARCHAR(255)'; 'value'='VARCHAR(255)'; 'comment'='VARCHAR(255)'
    'date-time'='TIMESTAMP'; 'date'='DATE'; 'currency-amount'='NUMERIC(18,3)'
    'currency-precise'='NUMERIC(18,6)'; 'fixed-point'='NUMERIC(18,6)'
    'numeric'='NUMERIC(20,0)'; 'floating-point'='DOUBLE'; 'very-short'='VARCHAR(10)'
    'url'='VARCHAR(2000)'; 'email'='VARCHAR(255)'
}

function Get-SqlType([string]$t) {
    if ($fieldMap.ContainsKey($t)) { return $fieldMap[$t] }
    return 'VARCHAR(255)'
}

New-Item -ItemType Directory -Force -Path $outDir | Out-Null
[xml]$doc = Get-Content $entityXml
$entities = @()
foreach ($entity in $doc.entitymodel.entity) {
    $fields = @()
    foreach ($f in $entity.field) { $fields += @{ name=$f.name; type=$f.type } }
    $pk = @($entity.'prim-key' | ForEach-Object { $_.field })
    $table = if ($entity.'table-name') { $entity.'table-name'.ToLower() } else { (ConvertTo-SnakeCase $entity.'entity-name').ToLower() }
    $entities += [pscustomobject]@{ Name=$entity.'entity-name'; Table=$table; Fields=$fields; Pk=$pk }
}
$entityNames = @{}
foreach ($e in $entities) { $entityNames[$e.Name] = $e.Table }

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("-- OFBiz order-entitymodel.xml ($($entities.Count) physical entities)")
[void]$sb.AppendLine("")
[void]$sb.AppendLine("CREATE TABLE IF NOT EXISTS status_type (status_type_id VARCHAR(20) NOT NULL PRIMARY KEY, parent_type_id VARCHAR(20), has_table CHAR(1), description VARCHAR(255));")
[void]$sb.AppendLine("CREATE TABLE IF NOT EXISTS status_item (status_id VARCHAR(20) NOT NULL PRIMARY KEY, status_type_id VARCHAR(20), status_code VARCHAR(60), sequence_id VARCHAR(20), description VARCHAR(255));")
[void]$sb.AppendLine("CREATE TABLE IF NOT EXISTS enumeration_type (enum_type_id VARCHAR(20) NOT NULL PRIMARY KEY, parent_type_id VARCHAR(20), has_table CHAR(1), description VARCHAR(255));")
[void]$sb.AppendLine("CREATE TABLE IF NOT EXISTS enumeration (enum_id VARCHAR(20) NOT NULL PRIMARY KEY, enum_type_id VARCHAR(20), enum_code VARCHAR(60), sequence_id VARCHAR(20), description VARCHAR(255));")
[void]$sb.AppendLine("CREATE TABLE IF NOT EXISTS status_valid_change (status_id VARCHAR(20) NOT NULL, status_id_to VARCHAR(20) NOT NULL, transition_name VARCHAR(255), PRIMARY KEY (status_id, status_id_to));")
[void]$sb.AppendLine("")

foreach ($e in $entities) {
    [void]$sb.AppendLine("CREATE TABLE IF NOT EXISTS $($e.Table) (")
    $cols = @()
    foreach ($f in $e.Fields) { $cols += "    $((ConvertTo-SnakeCase $f.name).ToLower()) $(Get-SqlType $f.type)" }
    if ($e.Pk.Count -gt 0) {
        $pkCols = ($e.Pk | ForEach-Object { (ConvertTo-SnakeCase $_).ToLower() }) -join ', '
        $cols += "    PRIMARY KEY ($pkCols)"
    }
    [void]$sb.AppendLine(($cols -join ",`n"))
    [void]$sb.AppendLine(");")
    [void]$sb.AppendLine("")
}

foreach ($entity in $doc.entitymodel.entity) {
    $srcTable = if ($entity.'table-name') { $entity.'table-name'.ToLower() } else { (ConvertTo-SnakeCase $entity.'entity-name').ToLower() }
    foreach ($rel in $entity.relation) {
        if ($rel.type -ne 'one' -or -not $rel.'fk-name') { continue }
        $relName = $rel.'rel-entity-name'
        if (-not $entityNames.ContainsKey($relName)) { continue }
        $dstTable = $entityNames[$relName]
        $srcCols = @(); $dstCols = @()
        foreach ($km in $rel.'key-map') {
            $src = $km.field
            if (-not $src) { continue }
            $dst = if ($km.'rel-field-name') { $km.'rel-field-name' } else { $km.field }
            $srcCols += (ConvertTo-SnakeCase $src).ToLower()
            $dstCols += (ConvertTo-SnakeCase $dst).ToLower()
        }
        if ($srcCols.Count -eq 0) { continue }
        [void]$sb.AppendLine("ALTER TABLE $srcTable ADD CONSTRAINT $($rel.'fk-name') FOREIGN KEY ($($srcCols -join ', ')) REFERENCES $dstTable ($($dstCols -join ', '));")
    }
}

$schemaPath = Join-Path $outDir "V1__order_schema.sql"
[System.IO.File]::WriteAllText($schemaPath, $sb.ToString())

[xml]$seed = Get-Content $seedXml
$seedSb = New-Object System.Text.StringBuilder
[void]$seedSb.AppendLine("-- OFBiz orderseeddata.xml")
foreach ($row in $seed.'entity-engine-xml'.ChildNodes) {
    if ($row.NodeType -ne 'Element') { continue }
    $table = (ConvertTo-SnakeCase $row.Name).ToLower()
    $cols = @(); $vals = @()
    foreach ($attr in $row.Attributes) {
        $cols += (ConvertTo-SnakeCase $attr.Name).ToLower()
        $v = $attr.Value.Replace("'", "''")
        $vals += "'$v'"
    }
    if ($cols.Count -eq 0) { continue }
    [void]$seedSb.AppendLine("INSERT INTO $table ($($cols -join ', ')) SELECT $($vals -join ', ') WHERE NOT EXISTS (SELECT 1 FROM $table WHERE $($cols[0]) = $($vals[0]));")
    [void]$seedSb.AppendLine("")
}
$seedPath = Join-Path $outDir "V2__order_seed.sql"
[System.IO.File]::WriteAllText($seedPath, $seedSb.ToString())

Write-Host "Generated $($entities.Count) tables -> $schemaPath"
Write-Host "Seed -> $seedPath"
