package com.village_batuse.village_batuse.async;

import android.content.Context;

public class AsyncUsbEscPosPrint extends AsyncEscPosPrint {
    public AsyncUsbEscPosPrint(Context context) {
        super(context);
    }

    public AsyncUsbEscPosPrint(Context context, OnPrintFinished onPrintFinished) {
        super(context, onPrintFinished);
    }
}