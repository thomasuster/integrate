package com.thomasuster.integrate.js;
import haxe.Timer;
import massive.munit.async.AsyncFactory;
class AsyncAssert {

    public static function register(context:Dynamic, factory:AsyncFactory, complete:Void->Void, wait:Int) {
        var handler:Dynamic = factory.createHandler(context, complete, wait+100);
        var timer:Timer = Timer.delay(handler, wait);
    }
}
   