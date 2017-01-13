set -e
cd tools/run
haxe compile.hxml
cd ../..
cd server
haxe build.hxml
cd ..
cd js
haxelib run haxe-sys-server test