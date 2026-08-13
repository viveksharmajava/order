package com.playpro.playpro.orders.repository;

import com.playpro.playpro.orders.entity.OrderFulfillmentItem;
import com.playpro.playpro.orders.entity.OrderFulfillmentItemId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface OrderFulfillmentItemRepository extends JpaRepository<OrderFulfillmentItem, OrderFulfillmentItemId> {

    List<OrderFulfillmentItem> findByOrderId(String orderId);

    List<OrderFulfillmentItem> findByIdFulfillmentId(String fulfillmentId);

    @Query("select coalesce(sum(i.quantity), 0) from OrderFulfillmentItem i "
            + "where i.orderId = :orderId and i.id.orderItemSeqId = :orderItemSeqId")
    BigDecimal sumShippedQuantity(@Param("orderId") String orderId,
                                  @Param("orderItemSeqId") String orderItemSeqId);
}
