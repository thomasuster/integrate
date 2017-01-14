set -e
cd tools/run
haxe compile.hxml -debug
cd ../..
cd server
haxe build.hxml -debug
cd ..
cd js
haxelib run haxe-sys-server test