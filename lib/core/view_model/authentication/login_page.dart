import 'package:appsmobile/core/app_constants/route.dart';
import 'package:appsmobile/core/model/authentication/login.dart';
import 'package:appsmobile/core/networks/aunthentication_network.dart';
import 'package:appsmobile/core/services/authentication_services.dart';
import 'package:appsmobile/core/services/navigation_services.dart';
import 'package:appsmobile/core/services/shared_preferences_services.dart';
import 'package:appsmobile/core/view_model/base_view_model.dart';
import 'package:flutter/material.dart';

class LoginPageModel extends BaseViewModel {
  LoginPageModel({
    required AunthencticationAPIServices authenticationAPI,
    required AuthenticationService authenticationService,
    required SharedPreferencesServices sharedPreferencesServices,
    required NavigationService navigationService,
  })  : _authenticationApi = authenticationAPI,
        _authenticationService = authenticationService,
        _sharedPreferencesService = sharedPreferencesServices,
        _navigationService = navigationService;

  final AunthencticationAPIServices _authenticationApi;
  final AuthenticationService _authenticationService;
  final SharedPreferencesServices _sharedPreferencesService;
  final NavigationService _navigationService;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Future<void> initModel() async {
    setBusy(true);
    setBusy(false);
  }

  Future<void> getLoggedInStatus() async {
    _navigationService.popAllAndNavigateTo(
      Routes.dashboard,
    );
  }

  Future<bool> requestLogin() async {
    final response = await _authenticationApi.login(
      username: usernameController.text,
      password: passwordController.text,
    );

    if (response.isRight) {
      final LoginResponse tokenLogin = response.right;
      await _sharedPreferencesService.set(
          SharedPrefKeys.tokenLogin, tokenLogin);
      return true;
    }
    return false;
  }
}
