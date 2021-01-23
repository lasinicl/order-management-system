import ballerina/io;

public function main() {
    OrderMgtClient orderEp = checkpanic new ("http://localhost:9090");
    OrderDetails[] orderList = [{
        id: 1,
        name: "Mike",
        noOfItems: 10,
        amount: 2500.00
    }, {
        id: 2,
        name: "Bianca",
        noOfItems: 23,
        amount: 10000.00
    }, {
        id: 3,
        name: "James",
        noOfItems: 30,
        amount: 5400.00
    }];
    foreach OrderDetails od in orderList {
        string|error result = orderEp->createOrder(od);
        if (result is string) {
            io:println(result);
        } else {
            io:println("Error occured when creating order.");
        }
    }

    OrderDetails|error result2 = orderEp->getOrder(3);
    if (result2 is OrderDetails) {
        io:println("Order " + result2.toString() + " successfully fetched.");
    } else {
        io:println("Error occured when fetching order.");
    }

    string|error result3 = orderEp->updateOrder(1);
    if (result3 is string) {
        io:println(result3);
    } else {
        io:println("Error occured when updating order.");
    }

    string|error result4 = orderEp->deleteOrder(2);
    if (result4 is string) {
        io:println(result4);
    } else {
        io:println("Error occured when deleting order.");
    }
}
