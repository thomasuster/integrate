package ;
import com.example.ExampleClient;
class ExampleClientMain {
    
    static function main() {
        var client:ExampleClient = new ExampleClient();
        client.args = Sys.args().join('');
        client.start();
    }
}