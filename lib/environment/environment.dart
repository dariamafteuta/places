import 'package:flutter_job/environment/build_config.dart';
import 'package:flutter_job/environment/build_type.dart';

class Environment {
  static late Environment _environment;
  final BuildConfig buildConfig;
  final BuildType buildType;

  Environment._({
    required this.buildConfig,
    required this.buildType,
  });

  static void init(
     BuildConfig buildConfig, BuildType buildType,) {
    _environment = Environment._(
      buildConfig: buildConfig,
      buildType: buildType,
    );
  }

  static Environment instance() => _environment;
}
