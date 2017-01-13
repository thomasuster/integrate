package ;
import haxe.io.Bytes;
import js.html.Uint8Array;
import js.html.ArrayBuffer;
import js.html.FileReader;
import js.html.Event;
import js.html.MessageEvent;
import js.html.WebSocket;
class ExampleClient {

    public var ws:WebSocket;
    public var fromServer:String;

    static function main() {
        new ExampleClient();
    }

    public function new():Void {
        connect();
        loop();
    }

    function loop():Void {
        var window:Dynamic = js.Browser.window;
        var rqf:Dynamic = window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame;
        update();
        rqf(loop);
    }

    function connect():Void {
        ws = new WebSocket("ws://localhost:4001");
        ws.onopen = handleJSOpen;
        ws.onclose = handleJSClose;
        ws.onmessage = cast handleJSMessage;
        ws.onerror = cast handleJSError;
    }

    function update():Void {
        if(ws.readyState == WebSocket.OPEN) {
            ws.send('ping');
        }
        if(ws.readyState == WebSocket.CLOSED)
            connect();
    }

    function handleJSOpen(evt:Event) {
    }

    function handleJSClose(evt:Event) {
    }

    function handleJSMessage(evt:MessageEvent) {
        var fileReader:FileReader = new FileReader();
        fileReader.onload = function() {
            var buffer:ArrayBuffer = fileReader.result;
            var view:Uint8Array = new Uint8Array(buffer);
            var s:String = '';
            for (i in 0...view.length) {
                var char:Int = view[i];
                s += String.fromCharCode(char);
            }
            fromServer = s;
        };
        fileReader.readAsArrayBuffer(evt.data);
    }

    function handleJSError(evt:MessageEvent) {
    }
}