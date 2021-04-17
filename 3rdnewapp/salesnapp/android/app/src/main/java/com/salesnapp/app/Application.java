package com.salesnapp.app;

import com.transistorsoft.flutter.backgroundfetch.BackgroundFetchPlugin;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;

public class Application extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
        BackgroundFetchPlugin.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        BackgroundFetchPlugin.registerWith(registry.registrarFor("com.transistorsoft.flutter.backgroundfetch.BackgroundFetchPlugin"));
    }
}