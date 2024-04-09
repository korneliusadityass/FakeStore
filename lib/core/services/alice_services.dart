import 'package:alice_lightweight/core/alice_core.dart';
import 'package:alice_lightweight/ui/page/alice_calls_list_screen.dart';
import 'package:appsmobile/core/app_constants/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';

import '../../main.dart';

final Provider<AliceCore> aliceCoreProvider =
    Provider<AliceCore>((ProviderRef<AliceCore> ref) {
  return AliceCore(
    navigatorKey,
    false,
  );
});

class AliceService {
  AliceService(GlobalKey<NavigatorState> navigatorKey) {
    bool enableAlice = false;

    switch (EnvConstants.env) {
      case EnvironmentEnum.dev:
      case EnvironmentEnum.staging:
        enableAlice = true;
        break;
      case EnvironmentEnum.production:
        enableAlice = false;
        break;
      default:
    }

    _aliceCore = AliceCore(
      navigatorKey,
      false,
    );

    if (enableAlice) {
      ShakeDetector.autoStart(
        onPhoneShake: _aliceCore.navigateToCallListScreen,
        shakeThresholdGravity: 5,
      );
    }
  }
  late AliceCore _aliceCore;
  AliceCore get aliceCore => _aliceCore;

  bool _isInspectorOpened = false;

  void navigateToCallListScreen() {
    final BuildContext? context = _aliceCore.getContext();
    if (context != null && !_isInspectorOpened) {
      _isInspectorOpened = true;
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AliceCallsListScreen(_aliceCore),
        ),
      ).then((_) => _isInspectorOpened = false);
    }
  }
}
