import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);

map<OrderDetails> orderMap = {};

type Error distinct error;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "OrderMgt" on ep {

    remote function createOrder(OrderMgtStringCaller caller, OrderDetails value) {
        string keyVal = value.id.toString();
        if (!orderMap.hasKey(keyVal)) {
            orderMap[keyVal] = value;
            log:print("Create order:" + value.toString());
            string message = "Order " + orderMap.get(keyVal).toString() + " successfully added.";
            grpc:Error? err = caller->sendString(message);
            if (err is grpc:Error) {
                log:printError("Couldn't create order!", {"error": err.message()});
            }
            checkpanic caller->complete();
        } else {
            logError(true, keyVal);
        }
    }

    remote function getOrder(OrderMgtOrderDetailsCaller caller, int value) {
        string keyVal = value.toString();
        if (orderMap.hasKey(keyVal)) {
            log:print("Fetch order with order id:" + keyVal);
            OrderDetails orderResult = orderMap.get(keyVal);
            grpc:Error? err = caller->sendOrderDetails(orderResult);
            if (err is grpc:Error) {
                log:printError("Couldn't fetch order!", {"error": err.message()});
            }
            checkpanic caller->complete();
        } else {
            logError(false, keyVal);
        }
    }

    remote function updateOrder(OrderMgtStringCaller caller, int value) {
        string keyVal = value.toString();
        if (orderMap.hasKey(keyVal)) {
            log:print("Update order with order id:" + keyVal);
            OrderDetails order1 = orderMap.get(keyVal);
            order1.name = "Michael";
            order1.noOfItems = 25;
            orderMap[keyVal] = order1;
            string message = "Order id:" + keyVal + " successfully updated to " + orderMap[keyVal].toString();
            grpc:Error? err = caller->sendString(message);
            if (err is grpc:Error) {
                log:printError("Couldn't update order!", {"error": err.message()});
            }
            checkpanic caller->complete();
        } else {
            logError(false, keyVal);
        }
    }

    remote function deleteOrder(OrderMgtStringCaller caller, int value) {
        string keyVal = value.toString();
        OrderDetails? deletedOrder = orderMap.removeIfHasKey(keyVal);
        if (deletedOrder is OrderDetails) {
            log:print("Delete order with order id:" + keyVal);
            string message = "Order " + deletedOrder.toString() + " successfully deleted.";
            grpc:Error? err = caller->sendString(message);
            if (err is grpc:Error) {
                log:printError("Couldn't delete order!", {"error": err.message()});
            }
            checkpanic caller->complete();
        } else {
            logError(false, keyVal);
        }
    }
}

# Logs error if the order id already exists or not
#
# + hasKey - order id exists or not
# + id - order id
function logError(boolean hasKey, string id) {
    Error err;
    if (hasKey) {
        err = error Error("Order id " + id + " already exists");
    } else {
        err = error Error("Order id " + id + " does not exist");
    }
    log:printError("Error occured!", {"error": err.message()});
}
