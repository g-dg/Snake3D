Snake, but in 3D!
=================

- [Play in web browser](https://garnetdg.ca/garnetdegelder/projects/snake3d/Snake3D.html) (requires WebAssembly, WebGL 2.0, and SharedArrayBuffer, probably won’t work on macOS or iOS)
- Download (latest version):
	- Windows [64-bit](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_windows_x86_64.zip) / [32-bit](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_windows_x86_32.zip) (extract and run Snake3D.exe, not signed, click “More info”, and “Run anyway” if blocked by SmartScreen)
	- Linux [64-bit](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_linux_x86_64.tar.gz) / [32-bit](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_linux_x86_32.tar.gz) / [arm64](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_linux_arm64.tar.gz) / [arm32](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_linux_arm32.tar.gz) (extract and run Snake3D.&lt;architecture&gt;)
	- [MacOS](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_macos.zip) (not tested, not signed, will be blocked by Gatekeeper, no idea how to run it - I just clicked the export button)
	- [Android](https://garnetdg.ca/garnetdegelder/projects/snake3d/builds/snake3d_android.apk) (apk, not signed, not tested)

Controls:
---------
- WASD: move
- Esc: pause/resume
- Q/E: rotate camera
- Has controller support (partially broken in some web browsers)
- Has basic touch support (tap and drag to rotate)
- May add gyro support in the future

Requirements:
-------------

### Recommended:
- Vulkan 1.2 Support

### Minimum:
- OpenGL 3.3 Support (requires running with command line argument `--rendering-driver opengl3`)

### Web browser:
- Webassembly
- WebGL2
- SharedArrayBuffer
