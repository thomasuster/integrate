package ;
import sys.io.File;
import sys.io.FileOutput;
import com.thomasuster.ws.FrameWriter;
import haxe.io.Bytes;
import com.thomasuster.ws.FrameReader;
import com.thomasuster.ws.HandShaker;
import com.thomasuster.ws.output.BytesOutputReal;
import com.thomasuster.ws.input.BytesInputReal;
import sys.net.Host;
import sys.net.Socket;
class ExampleServer {

    var socket:Socket;
    var s:Socket;
    var input:BytesInputReal;
    var output:BytesOutputReal;

    public static function main() {
        new ExampleServer();
    }
    
    public function new():Void {
        start();
        while(true)
            update();
    }

    public function start():Void {
        print('start');
        socket = new Socket();
        socket.setBlocking(true);
        socket.setTimeout(60);
        socket.bind(new Host('localhost'),4001);
        socket.listen(1);
    }

    public function update():Void {
        s = socket.accept();
        print('accept');
        
        input = new BytesInputReal();
        input.input = s.input;
        output = new BytesOutputReal();
        output.output = s.output;

        var shaker:HandShaker = new HandShaker();
        shaker.input = input;
        shaker.output = output;
        shaker.shake();

        var reader:FrameReader = new FrameReader();
        reader.input = input;

        while(true) {
            var toServer:Bytes = reader.read();
            
            print(toServer.toString());
//            print('' + reader.payloadLength);
            
//            print(Sys.args()[Sys.args().length-1]);
            if(Sys.args().length > 0 && Sys.args()[Sys.args().length-1] == '-fortyTwo')
                writeString('fortyTwo');
            else if(toServer.toString() == 'ping') {
                writeString('pong');
            }
            else if(toServer.toString() == 'marco') {
                writeString('polo');
            }
        }
    }

    function writeString(s:String):Void {
        var writer:FrameWriter = new FrameWriter();
        writer.output = output;
        writer.payload = Bytes.ofString(s);
        writer.write();
    }

    public function print(s:String):Void {
        var write:FileOutput = File.append('logs.txt');
        write.writeString('$s \n');
        write.close();
    }
}