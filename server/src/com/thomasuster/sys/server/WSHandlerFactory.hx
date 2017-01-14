package com.thomasuster.sys.server;
import hxnet.interfaces.Protocol;
import hxnet.interfaces.Factory;
class WSHandlerFactory implements Factory {
    
    public var model:ServerModel;

    public function new():Void {}

    public function buildProtocol():Protocol {
        var p:WSHandler = new WSHandler();
        p.model = model;
        return p;
    }
}
   