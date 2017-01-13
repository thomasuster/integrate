package ;
import js.html.Element;
import js.Browser;
import js.html.MouseEvent;
import js.html.Document;
import js.Lib;
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

    function onClick(e:Event):Void {
        if(ws.readyState == WebSocket.OPEN) {
            trace("ping");
            ws.send('ping');
        }
    }
    
    public function new():Void {
        var document:Document = Browser.document;
        var div:Element = document.createElement('button');
        div.id = 'ping';
        div.style.width = "100px";
        div.style.height = "100px";
        div.style.background = "#00FF00";
        document.getElementsByTagName('body').item(0).appendChild(div);
        div.addEventListener('click', onClick);
        connect();
    }
    
    function connect():Void {
        ws = new WebSocket("ws://localhost:4000");
        ws.onopen = handleJSOpen;
        ws.onclose = handleJSClose;
        ws.onmessage = cast handleJSMessage;
        ws.onerror = cast handleJSError;
    }

    function handleJSOpen(evt:Event) {
        trace('handleJSOpen\n');
    }

    function handleJSClose(evt:Event) {
        trace('handleJSOpen\n');
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

    function handleJSError(evt:MessageEvent)
    {
        trace("Error: " + evt.data + '\n');
    }
}