package com.thomasuster.sys.js;
import String;
import js.html.Uint8Array;
import js.html.ArrayBuffer;
import js.html.Event;
import js.html.FileReader;
import js.html.MessageEvent;
import js.html.WebSocket;
class WebSocketClient {

    var ws:WebSocket;
    var id:Int;
    var commands:Array<String>;

    public function new():Void {
        commands = [];
    }

    public function connect():Void {
        ws = new WebSocket("ws://localhost:4000");
        ws.onopen = handleJSOpen;
        ws.onclose = handleJSClose;
        ws.onmessage = cast handleJSMessage;
        ws.onerror = cast handleJSError;
        loop();
    }

    public function disconnect():Void {
        ws.close(0,'Complete');
    }

    public function send(command:String, args:Array<String>):Void {
        args.unshift(command);
        commands.push(args.join(','));
    }

    public function runFrom(from:String, command:String, args:Array<String>):Void {
        args = ['runFrom',from,command].concat(args);
        commands.push(args.join(','));
    }

    public function killAll():Void {
        commands.push('killAll');
    }

    function loop():Void {
        var window:Dynamic = js.Browser.window;
        var rqf:Dynamic = window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame;
        update();
        rqf(loop);
    }

    function update():Void {
        if(ws.readyState == WebSocket.OPEN) {
            if(commands.length > 0) {
                var command:String = commands.shift();
                ws.send(command);   
            }
        }
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
            handleString(s);
        };
        fileReader.readAsArrayBuffer(evt.data);
    }

    function handleString(s:String):Void {
        id = Std.parseInt(s);
    }

    function handleJSError(evt:MessageEvent) {
        trace("Error: " + evt.data + '\n');
    }
}
   