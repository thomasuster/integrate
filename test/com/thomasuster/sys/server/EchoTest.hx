package com.thomasuster.sys.server;
import sys.io.Process;
class EchoTest extends haxe.unit.TestCase {

    var process:Process;

    public override function setup() {
        process = new Processq('haxelib',['run','haxe-sys-server','start']);
    }

    public override function tearDown() {
        process.kill();        
    }

    public function testEcho() {
        
    }
}