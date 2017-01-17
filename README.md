## Integrate
 
Full integration testing for your (haxe->js + server) applications.

### Build it

```
git clone git@github.com:thomasuster/integrate.git
haxelib dev integrate integrate
git clone git@github.com:thomasuster/haxe-websocket-server.git
haxelib dev haxe-websocket-server haxe-websocket-server
git clone https://github.com/MattTuttle/hxnet.git
haxelib dev hxnet hxnet
haxelib install munit
haxelib install hamcrest

cd integrate
sh build.sh
```

### Use it
```
cd ~
haxelib run integrate create my_new_project
cd my_new_project/test
haxelib run integrate test
```