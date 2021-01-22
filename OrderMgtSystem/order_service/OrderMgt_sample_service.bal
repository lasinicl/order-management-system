import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);
map<OrderDetails> orderMap = {};

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "OrderMgt" on ep {

    remote function createOrder(OrderMgtStringCaller caller, OrderDetails value) {
        orderMap[value.id.toString()] = value;
        log:print("Create order:" + orderMap.get(value.id.toString()).toString());
        string message = "Order " + value.toString() + " successfully added.";
        grpc:Error? err = caller->sendString(message);
        if (err is grpc:Error) {
            log:printError("Couldn't create order:", {"error": err.message()});
        }
        checkpanic caller->complete();
    }
    
    remote function getOrder(OrderMgtOrderDetailsCaller caller, int value) {
        OrderDetails orderResult = orderMap.get(value.toString());
        grpc:Error? err = caller->sendOrderDetails(orderResult);
        log:print("Fetch order with order id:" + value.toString());
        if (err is grpc:Error) {
            log:printError("Couldn't fetch order:", {"error": err.message()});
        }
        checkpanic caller->complete();
    }

    remote function updateOrder(OrderMgtStringCaller caller, int value) {
        if (orderMap.hasKey(value.toString())) {
            OrderDetails order1 = orderMap.get(value.toString());
            order1.name = "Michael";
            string message = "Order id:" + value.toString() + " successfully updated to " + order1.toString();
            grpc:Error? err = caller->sendString(message);
            if (err is grpc:Error) {
                log:print("Couldn't update order:", {"error": err.message()});
            }
            checkpanic caller->complete();
        } else {
            error err = error("Order id does not exist");
            log:printError("Updating order failed:", {"error": err.message()});
        }
    }

    remote function deleteOrder(OrderMgtStringCaller caller, int value) {
        if (orderMap.hasKey(value.toString())) {
            OrderDetails deletedOrder = orderMap.remove(value.toString());
            string message = "Order " + deletedOrder.toString() + " successfully deleted.";
            grpc:Error? err = caller->sendString(message);
            if (err is grpc:Error) {
                log:print("Couldn't update order:", {"error": err.message()});
            }
            checkpanic caller->complete();
        } else {
            error err = error("Order id does not exist");
            log:printError("Deleting order failed:", {"error": err.message()});
        }
    }
}
