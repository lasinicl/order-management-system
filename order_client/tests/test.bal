import ballerina/test;

@test:Config {
    enable: true
}
function testCreateOrder() {
    OrderMgtClient testEp = checkpanic new ("http://localhost:9090");
    OrderDetails[] orderList = [{
        id: 11,
        name: "Chandler",
        noOfItems: 10,
        amount: 2500.00
    }, {
        id: 22,
        name: "Monica",
        noOfItems: 23,
        amount: 10000.00
    }, {
        id: 33,
        name: "Joey",
        noOfItems: 30,
        amount: 5400.00
    },{
        id: 44,
        name: "Ross",
        noOfItems: 45,
        amount: 15000.00
    }];

    foreach OrderDetails od in orderList {
        string|error result = testEp->createOrder(od);
        if (result is string) {
            test:assertEquals(result, "Order " + od.toString() + " successfully added.");
        } 
    }
}

@test:Config {
    enable: false
}
function testGetOrder() {
    OrderMgtClient testEp = checkpanic new ("http://localhost:9090");
    OrderDetails|error result = testEp->getOrder(33);
    if (result is OrderDetails) {
        test:assertEquals(result.toString(), "{\"id\":33,\"name\":\"Joey\",\"noOfItems\":30,\"amount\":5400.0}");
    } 
}

@test:Config {
    enable: true
}
function testUpdateOrder() {
    OrderMgtClient testEp = checkpanic new ("http://localhost:9090");
    string|error result = testEp->updateOrder(11);
    if (result is string) {
        test:assertEquals(result, "Order id:11 successfully updated to {\"id\":11,\"name\":\"Michael\"," + 
        "\"noOfItems\":25,\"amount\":2500.0}");
    } 
}

@test:Config {
    enable: false
}
function testDeleteOrder() {
    OrderMgtClient testEp = checkpanic new ("http://localhost:9090");
    string|error result = testEp->deleteOrder(44);
    if (result is string) {
        test:assertEquals(result, "Order {\"id\":44,\"name\":\"Ross\",\"noOfItems\":45,\"amount\":15000.0}" + 
        " successfully deleted.");
    } 
}
