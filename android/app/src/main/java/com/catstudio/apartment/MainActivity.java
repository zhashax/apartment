package com.catstudio.apartment;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import com.yandex.mapkit.MapKitFactory;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
         // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("111aed7b-2935-4826-9973-9b85c494aa28"); // Your generated API key
        super.configureFlutterEngine(flutterEngine);
    }
}
