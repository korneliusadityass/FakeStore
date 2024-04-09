import 'package:appsmobile/core/networks/aunthentication_network.dart';
import 'package:appsmobile/core/services/authentication_services.dart';
import 'package:appsmobile/core/services/navigation_services.dart';
import 'package:appsmobile/core/services/shared_preferences_services.dart';
import 'package:appsmobile/core/view_model/authentication/login_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/loading.dart';
import 'package:appsmobile/ui/shared/unfocus_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewParam {
  LoginViewParam({
    this.tokenLogin,
  });

  final String? tokenLogin;
}

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    required this.param,
    super.key,
  });

  final LoginViewParam param;

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final FocusNode _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModel<LoginPageModel>(
        model: LoginPageModel(
          authenticationAPI: ref.read(aunthencticationAPI),
          authenticationService: ref.read(authProvider),
          sharedPreferencesServices: ref.read(sharedPrefProvider),
          navigationService: ref.read(navigationProvider),
        ),
        builder: (_, LoginPageModel model, __) {
          return LoadingOverlay(
              isLoading: model.busy,
              child: UnfocusHelper(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: SafeArea(
                        child: Column(
                      children: <Widget>[
                        Image.asset(
                          'asset/image/NO8hx.png',
                          width: double.infinity,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ));
        });
  }
}
