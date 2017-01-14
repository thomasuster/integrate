package com.thomasuster.sys.tool;
class ServerTerminator {
    
    public function new():Void {
    }

    public function terminate():Void {
        var s = new sys.net.Socket();
        s.setBlocking(true);
        while(true) {
            try {
                s.connect(new sys.net.Host("localhost"),4002);
                break;
            }
            catch(e:Dynamic) {}
        }
        s.output.writeString('close');
        s.close();
    }
}