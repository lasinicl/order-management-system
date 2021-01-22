import ballerina/grpc;

public client class OrderMgtClient {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public isolated function init(string url, grpc:ClientConfiguration? config = ()) returns grpc:Error? {
        // initialize client endpoint.
        self.grpcClient = check new(url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function createOrder(OrderDetails|ContextOrderDetails req) returns (string|grpc:Error) {
        
        map<string|string[]> headers = {};
        OrderDetails message;
        if (req is ContextOrderDetails) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/createOrder", message, headers);
        [anydata, map<string|string[]>][result, _] = payload;
        return result.toString();
    }
    isolated remote function createOrderContext(OrderDetails|ContextOrderDetails req) returns (ContextString|grpc:Error) {
        
        map<string|string[]> headers = {};
        OrderDetails message;
        if (req is ContextOrderDetails) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/createOrder", message, headers);
        [anydata, map<string|string[]>][result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function getOrder(int|ContextInt req) returns (OrderDetails|grpc:Error) {
        
        map<string|string[]> headers = {};
        int message;
        if (req is ContextInt) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/getOrder", message, headers);
        [anydata, map<string|string[]>][result, _] = payload;
        
        return <OrderDetails>result;
        
    }
    isolated remote function getOrderContext(int|ContextInt req) returns (ContextOrderDetails|grpc:Error) {
        
        map<string|string[]> headers = {};
        int message;
        if (req is ContextInt) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/getOrder", message, headers);
        [anydata, map<string|string[]>][result, respHeaders] = payload;
        
        return {content: <OrderDetails>result, headers: respHeaders};
    }

    isolated remote function updateOrder(int|ContextInt req) returns (string|grpc:Error) {
        
        map<string|string[]> headers = {};
        int message;
        if (req is ContextInt) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/updateOrder", message, headers);
        [anydata, map<string|string[]>][result, _] = payload;
        return result.toString();
    }
    isolated remote function updateOrderContext(int|ContextInt req) returns (ContextString|grpc:Error) {
        
        map<string|string[]> headers = {};
        int message;
        if (req is ContextInt) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/updateOrder", message, headers);
        [anydata, map<string|string[]>][result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function deleteOrder(int|ContextInt req) returns (string|grpc:Error) {
        
        map<string|string[]> headers = {};
        int message;
        if (req is ContextInt) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/deleteOrder", message, headers);
        [anydata, map<string|string[]>][result, _] = payload;
        return result.toString();
    }
    isolated remote function deleteOrderContext(int|ContextInt req) returns (ContextString|grpc:Error) {
        
        map<string|string[]> headers = {};
        int message;
        if (req is ContextInt) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OrderMgt/deleteOrder", message, headers);
        [anydata, map<string|string[]>][result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

}




public type OrderDetails record {|
    int id = 0;
    string name = "";
    
|};

public type ContextString record {|
    string content;
    map<string|string[]> headers;
|};

public type ContextOrderDetails record {|
    OrderDetails content;
    map<string|string[]> headers;
|};

public type ContextInt record {|
    int content;
    map<string|string[]> headers;
|};


const string ROOT_DESCRIPTOR = "0A176F726465725F6D67745F736572766963652E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22320A0C4F7264657244657461696C73120E0A0269641801200128055202696412120A046E616D6518022001280952046E616D653292020A084F726465724D6774123A0A0B6372656174654F72646572120D2E4F7264657244657461696C731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512360A086765744F72646572121B2E676F6F676C652E70726F746F6275662E496E74333256616C75651A0D2E4F7264657244657461696C7312480A0B7570646174654F72646572121B2E676F6F676C652E70726F746F6275662E496E74333256616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512480A0B64656C6574654F72646572121B2E676F6F676C652E70726F746F6275662E496E74333256616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33";
isolated function getDescriptorMap() returns map<string> {
    return {
        "order_mgt_service.proto":"0A176F726465725F6D67745F736572766963652E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22320A0C4F7264657244657461696C73120E0A0269641801200128055202696412120A046E616D6518022001280952046E616D653292020A084F726465724D6774123A0A0B6372656174654F72646572120D2E4F7264657244657461696C731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512360A086765744F72646572121B2E676F6F676C652E70726F746F6275662E496E74333256616C75651A0D2E4F7264657244657461696C7312480A0B7570646174654F72646572121B2E676F6F676C652E70726F746F6275662E496E74333256616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512480A0B64656C6574654F72646572121B2E676F6F676C652E70726F746F6275662E496E74333256616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33",
        "google/protobuf/wrappers.proto":"0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
        
    };
}

