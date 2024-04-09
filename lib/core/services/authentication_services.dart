import 'package:appsmobile/core/model/authentication/login.dart';
import 'package:appsmobile/core/services/navigation_services.dart';
import 'package:appsmobile/core/services/shared_preferences_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<AuthenticationService> authProvider = Provider<AuthenticationService>(
  (ProviderRef<AuthenticationService> ref) {
    return AuthenticationService(
      navigationService: ref.watch(navigationProvider),
      sharedPreferencesService: ref.watch(sharedPrefProvider),
    );
  },
);

class AuthenticationService {
  AuthenticationService({
    required SharedPreferencesServices sharedPreferencesService,
    required NavigationService navigationService,
  }) : _sharedPreferencesService = sharedPreferencesService;
  // _navigationService = navigationService;

  final SharedPreferencesServices _sharedPreferencesService;
  // final NavigationService _navigationService;

  Future<bool> isLoggedIn() async {
    final LoginResponse? login = await _sharedPreferencesService.get(
      SharedPrefKeys.tokenLogin,
    );
    print(login?.token);
    return login?.token != null;
  }
}
