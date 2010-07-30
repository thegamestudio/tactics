all: build run

build:
	/Users/noah/Library/flex_sdk_3/bin/mxmlc -target-player 10.0.0 -default-size 640 480 -static-link-runtime-shared-libraries -o bin/tactic.swf src/Main.as

run:
	/Applications/Utilities/Flash\ Player.app/Contents/MacOS/Flash\ Player `pwd`/bin/tactic.swf
