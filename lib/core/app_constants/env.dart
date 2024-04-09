import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:global_configuration/global_configuration.dart';

class EnvConstants {
  static final GlobalConfiguration _config = GlobalConfiguration();

  static EnvironmentEnum? _getEnvEnum(String environment) =>
      envMapping[environment];

  static EnvironmentEnum? get env {
    return _getEnvEnum(dotenv.env['ENV'] ?? '');
  }

  static String get accountBaseUrl {
    return dotenv.env['ACCOUNT_BASE_URL'] ?? '';
  }
}

enum EnvironmentEnum {
  dev,
  staging,
  production,
}

extension EnvironmentEnumExtension on EnvironmentEnum {
  static const Map<EnvironmentEnum, String> values = <EnvironmentEnum, String>{
    EnvironmentEnum.dev: 'dev',
    EnvironmentEnum.staging: 'staging',
    EnvironmentEnum.production: 'production',
  };

  String? get value => values[this];
}

Map<String?, EnvironmentEnum> envMapping = <String?, EnvironmentEnum>{
  EnvironmentEnum.dev.value: EnvironmentEnum.dev,
  EnvironmentEnum.staging.value: EnvironmentEnum.staging,
  EnvironmentEnum.production.value: EnvironmentEnum.production,
};