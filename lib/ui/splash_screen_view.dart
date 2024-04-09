import 'package:appsmobile/core/services/authentication_services.dart';
import 'package:appsmobile/core/services/navigation_services.dart';
import 'package:appsmobile/core/view_model/splash_screen_view_model.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreenView extends ConsumerWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ViewModel<SplashScreenViewModel>(
        model: SplashScreenViewModel(
          navigationService: ref.read(navigationProvider),
          authenticationService: ref.read(authProvider),
        ),
        onModelReady: (SplashScreenViewModel model) => model.initModel(),
        builder: (_, SplashScreenViewModel model, __) {
          final Size windowSize = MediaQuery.of(context).size;
          return Scaffold(
            body: Container(
              width: windowSize.width,
              height: windowSize.height,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image/mjk-logo.png',
                  ),
                  fit: BoxFit.none,
                ),
              ),
            ),
          );
        });
  }
}
