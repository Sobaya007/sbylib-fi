module sbylib.wrapper.freeimage.FreeImage;

import derelict.freeimage.freeimage;
import derelict.util.exception;

import sbylib.wrapper.freeimage.Constants;

private ShouldThrow missingSymFunc(string symName) {
    return ShouldThrow.No;
}

class FreeImage {

    private static FreeImage instance;

    static FreeImage opCall() {
        if (instance is null) instance = new FreeImage();
        return instance;
    }

    private this() {
        DerelictFI.missingSymbolCallback = &missingSymFunc;
        DerelictFI.load();
    }

    string getVersion() {
        import std.conv;
        return FreeImage_GetVersion().to!string;
    }

    FIBITMAP* allocate(int width, int height, int bpp) {
        return FreeImage_Allocate(width, height, bpp);
    }

    FIBITMAP* allocate(int width, int height, int bpp, ImageType type) {
        return FreeImage_AllocateT(type, width, height, bpp);
    }

    FIBITMAP* load(ImageFormat format, string path, int option) {
        import std.string : toStringz;
        return FreeImage_Load(format, path.toStringz, option);
    }

    void unload(FIBITMAP* bitmap) {
        FreeImage_Unload(bitmap);
    }

    FIBITMAP* convertTo32Bits(FIBITMAP* bitmap) {
        return FreeImage_ConvertTo32Bits(bitmap);
    }

    int getWidth(FIBITMAP* bitmap) {
        return FreeImage_GetWidth(bitmap);
    }

    int getHeight(FIBITMAP* bitmap) {
        return FreeImage_GetHeight(bitmap);
    }

    int getBPP(FIBITMAP* bitmap) {
        return FreeImage_GetBPP(bitmap);
    }

    void* getBits(FIBITMAP* bitmap) {
        return FreeImage_GetBits(bitmap);
    }

    ImageFormat getFileType(string path) {
        import std.string : toStringz;
        // 第2引数は現在使われていないらしい。
        return cast(ImageFormat)FreeImage_GetFileType(path.toStringz,0);
    }
}
