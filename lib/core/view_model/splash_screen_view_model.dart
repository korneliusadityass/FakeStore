// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:appsmobile/core/app_constants/route.dart';
import 'package:appsmobile/core/services/authentication_services.dart';
import 'package:appsmobile/core/services/navigation_services.dart';
import 'package:appsmobile/core/view_model/base_view_model.dart';
import 'package:appsmobile/ui/views/authentication/login_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreenViewModel extends BaseViewModel {
  SplashScreenViewModel({
    required NavigationService navigationService,
    required AuthenticationService authenticationService,
  })  : _navigationService = navigationService,
        _authenticationService = authenticationService;

  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;

  String? _tokenLogin;
  String? get tokenLogin => _tokenLogin;

  @override
  Future<void> initModel() async {
    _navigateToMainMenu();
    // _tokenFCM = await FirebaseMessaging.instance.getToken();
  }

  void _navigateToMainMenu() async {
    final bool isLoggedIn = await _authenticationService.isLoggedIn();

    FlutterNativeSplash.remove();
    if (isLoggedIn) {
      _navigationService.popAllAndNavigateTo(
        Routes.dashboard,
      );
      return;
    }
    _navigationService.popAllAndNavigateTo(
      Routes.login,
      arguments: LoginViewParam(
        tokenLogin: tokenLogin,
      ),
    );
  }
}
