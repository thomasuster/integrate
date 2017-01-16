import sys.FileSystem;
import sys.io.File;
import com.thomasuster.integrate.tool.SysServerPorts;
import com.thomasuster.integrate.tool.PIDFinder;
import com.thomasuster.integrate.tool.ProcessPrinter;
import com.thomasuster.integrate.tool.ServerTerminator;
import sys.io.Process;
class RunMain {
    
    var commands:Map<String, Void->Void>;
    var server:Process;
    var finder:PIDFinder;
    var printer:ProcessPrinter;
    var serverTerminator:ServerTerminator;

    public static function main() {
        new RunMain();
    }

    public function new():Void {
        finder = new PIDFinder();
        printer = new ProcessPrinter();
        serverTerminator = new ServerTerminator();
        commands = new Map<String, Void->Void>();
        commands.set('create', create);
        commands.set('test', test);
        commands.set('find', find);
        commands.set('kill', kill);
        commands.set('killAll', killAll);
        var command:String = Sys.args()[0];
        if(commands.exists(command))
            commands.get(command)();
        else
            Sys.println('Command not found \'$command\'');
    }

    function create():Void {
        var last:String = Sys.getCwd();
        var sourcedir:String = '${last}example';
        var original:String = Sys.args()[2];
        var relative:String = Sys.args()[1];
        var destdir:String = original+relative;
        var command:String = 'cp -R $sourcedir $destdir';
        var split:Array<String> = command.split(' ');
        Sys.command(split.shift(), split);
    }

    function killAll():Void {
        killPort(SysServerPorts.MUNIT_PORT);
        killPort(SysServerPorts.SERVER_PORT);
    }

    function test():Void {
        killAll();
        
        var last:String = Sys.getCwd();

        var path:String = Sys.args()[Sys.args().length-1];
        
        Sys.setCwd('$last/server');
        server = new Process('neko',['Build.n', path]);

        Sys.setCwd(path);

        var process:Process = new Process('haxelib',['run','munit','test']);
        var code:Int = process.exitCode(true);

        serverTerminator.terminate();
        server.exitCode(true);

        printer.printAll(process);
        Sys.exit(code);
    }

    function find():Void {
        var port:Int = Std.parseInt(Sys.args()[1]);
        Sys.println(finder.findPID(port));
    }

    function killPort(port:Int):Void {
        var pid:Int = finder.findPID(port);
        if(pid != 0)
            Sys.command('kill',['$pid']);
    }

    function kill():Void {
        var port:Int = Std.parseInt(Sys.args()[1]);
        killPort(port);
    }
}