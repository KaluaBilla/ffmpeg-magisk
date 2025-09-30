# FFmpeg Magisk Module

This Module provides **FFmpeg and FFprobe** through a Magisk module.  
It installs dynamically linked FFmpeg binaries with hardware acceleration enabled.

---

## 📌 Features
- Dynamic linking with **hardware acceleration** (`mediacodec`, `OpenCL`, `JNI`)  
- Wide codecs and filter support
---

## Build Configuration
- Binaries are compiled using this configuration
- Binaries are built using [ffmpeg-android](https://github.com/KaluaBilla/ffmpeg-android) build scripts.
```
--enable-pic
--enable-gpl
--enable-version3
--enable-libx264
--enable-libx265
--enable-libvpx
--enable-libaom
--enable-libdav1d
--enable-libharfbuzz
--enable-libbs2b
--enable-libgsm
--enable-libtheora
--enable-libopenjpeg
--enable-libwebp
--enable-libxvid
--enable-libkvazaar
--enable-libxavs
--enable-libdavs2
--enable-libmp3lame
--enable-libvorbis
--enable-libopus
--enable-libtwolame
--enable-libsoxr
--enable-libvo-amrwbenc
--enable-libopencore-amrnb
--enable-libopencore-amrwb
--enable-libvvenc
--enable-libilbc
--enable-libcodec2
--enable-libmysofa
--enable-libopenmpt
--enable-libfreetype
--enable-libfontconfig
--enable-libfribidi
--enable-libass
--enable-libxml2
--enable-openssl
--enable-zlib
--enable-bzlib
--enable-libsnappy
--enable-libsrt
--enable-libzmq
--enable-librist
--enable-libaribb24
--enable-libvmaf
--enable-libzimg
--enable-liblensfun
--enable-libflite
--enable-libssh
--enable-libsvtav1
--enable-libuavs3d
--enable-librtmp
--enable-libgme
--enable-libjxl
--enable-vapoursynth
--enable-libqrencode
--enable-libquirc
--enable-libcaca
--enable-chromaprint
--enable-libspeex
--enable-libbluray
--enable-lcms2
--enable-avisynth
--enable-liblc3
--enable-liblcevc-dec
--enable-libmodplug
--enable-librubberband
--enable-libshine
--enable-libklvanc
--enable-librsvg
--enable-libxavs2
--enable-libxeve
--enable-libxevd
--enable-libzvbi
--enable-mediacodec
--enable-opencl
```


## 🚀 Installation
1. Download the module
2. Flash the module in **Magisk/KSU/APatch**.  
3. Reboot.  

## Notes
- Requires Android 10+
- On unsupported or older devices, binaries may fail to run.
- For compatibility with older Android versions, use the static binaries from [ffmpeg-android](https://github.com/KaluaBilla/ffmpeg-android/releases)


## License
- Follows the same license as FFmpeg (LGPL/GPL v2.1+), check the [FFmpeg license details](https://www.ffmpeg.org/legal.html)

## Credits

- [FFmpeg project](https://ffmpeg.org)
- [Magisk](https://github.com/topjohnwu/Magisk)
