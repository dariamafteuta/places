package com.mafteuta.placesApp.flutter_job

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("f2da2940-672b-4822-86b9-bd1ef9fef8f9")
        super.configureFlutterEngine(flutterEngine)
    }
}
