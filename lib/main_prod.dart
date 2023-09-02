import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job/app.dart';
import 'package:flutter_job/environment/build_config.dart';
import 'package:flutter_job/environment/build_type.dart';
import 'package:flutter_job/environment/environment.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

Future<void> main() async {
  _defineEnvironment(
    buildConfig: _setUpConfig(),
  );
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

void _defineEnvironment({required BuildConfig buildConfig}) {
  Environment.init(buildConfig, BuildType.debug);
}

BuildConfig _setUpConfig() {
  return BuildConfig(
    envString: '',
  );
}