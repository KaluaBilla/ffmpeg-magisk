FFMPEG_ARCH="$(getprop ro.product.cpu.abi)"
type="Dynamic"
API="29"

[ "${type}" = "Dynamic" ] && [ "$(getprop ro.build.version.sdk)" -lt "${API}" ] && ui_print "- WARNING: API Mismatch, Expected >= ${API}, is $(getprop ro.build.version.sdk)"

SYSTEM_DIR="$MODPATH/system"
mkdir -p "$SYSTEM_DIR"
cd "$SYSTEM_DIR" || exit 1

ui_print "- Extracting FFmpeg for ${FFMPEG_ARCH}"

case "${FFMPEG_ARCH}" in
    arm64-v8a)  tarball="$MODPATH/bins/arm64-v8a/ffmpeg.tar.xz" ;;
    armeabi-v7a) tarball="$MODPATH/bins/armeabi-v7a/ffmpeg.tar.xz" ;;
    x86)        tarball="$MODPATH/bins/x86/ffmpeg.tar.xz" ;;
    x86_64)     tarball="$MODPATH/bins/x86_64/ffmpeg.tar.xz" ;;
    *)
        ui_print "- Unsupported ABI '${FFMPEG_ARCH}'"
        abort
        ;;
esac

if [ ! -f "$tarball" ]; then
    ui_print "- FFmpeg archive not found for ABI '${FFMPEG_ARCH}'"
    abort
fi

tar -xf "$tarball"

if [ "$type" = "Dynamic" ]; then
    ui_print "- Dynamic libraries detected for $FFMPEG_ARCH"

    if echo "$FFMPEG_ARCH" | grep -q "64"; then
        libdir="lib64"
    else
        libdir="lib"
    fi

    mkdir -p "$SYSTEM_DIR/$libdir"

    if [ -f "/system/$libdir/libOpenCL.so" ]; then
        cp -a "/system/$libdir/libOpenCL.so" "$SYSTEM_DIR/$libdir/"
        ui_print "- Copied libOpenCL.so from /system/$libdir"
    elif [ -f "/system/vendor/$libdir/libOpenCL.so" ]; then
        cp -a "/system/vendor/$libdir/libOpenCL.so" "$SYSTEM_DIR/$libdir/"
        ui_print "- Copied libOpenCL.so from /system/vendor/$libdir"
    else
        ui_print "- libOpenCL.so not found in standard paths, searching /system..."
        found=$(find -L /system -iname "libOpenCL.so" | grep "$libdir" | head -n 1)
        if [ -n "$found" ]; then
            cp -a "$found" "$SYSTEM_DIR/$libdir/"
            ui_print "- Copied libOpenCL.so from $found"
        else
            ui_print "- WARNING: libOpenCL.so not found for $libdir!"
        fi
    fi

    set_perm_recursive "$SYSTEM_DIR" 0 0 0755 0644
    [ -d "$SYSTEM_DIR/bin" ] && chmod 755 "$SYSTEM_DIR/bin"/*

    export LD_LIBRARY_PATH="$SYSTEM_DIR/$libdir:$LD_LIBRARY_PATH"

    ui_print "- Testing..."
    for bin in "$SYSTEM_DIR/bin/ffmpeg" "$SYSTEM_DIR/bin/ffprobe"; do
        if [ -x "$bin" ]; then
            "$bin" -version >/dev/null 2>&1
            if [ $? -eq 0 ]; then
                ui_print "  $bin works!"
            else
                ui_print "- WARNING: $bin failed to run!"
            fi
        else
            ui_print "- WARNING: $bin not executable!"
            abort "Aborting Installation: Your Device Might Not be Supported"
        fi
    done
fi

rm -f "$tarball"
