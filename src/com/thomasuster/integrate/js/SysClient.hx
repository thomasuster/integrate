package com.thomasuster.integrate.js;
import String;
import js.html.Event;
import js.html.MessageEvent;
import js.html.WebSocket;
class SysClient {

    var ws:WebSocket;
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

    public function setCwd(path:String):Void {
        commands.push('setCwd $path');
    }

    public function send(s:String):Void {
        commands.push(s);
    }

    public function kill():Void {
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
    }
    
    function handleJSError(evt:MessageEvent) {
    }
}
   