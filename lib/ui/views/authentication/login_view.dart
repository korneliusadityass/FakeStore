import 'package:appsmobile/core/networks/authentication/aunthentication_network.dart';
import 'package:appsmobile/core/services/authentication_services.dart';
import 'package:appsmobile/core/services/navigation_services.dart';
import 'package:appsmobile/core/services/shared_preferences_services.dart';
import 'package:appsmobile/core/view_model/authentication/login_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/loading.dart';
import 'package:appsmobile/ui/shared/spacing.dart';
import 'package:appsmobile/ui/shared/unfocus_helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_constants/route.dart';

class LoginViewParam {
  LoginViewParam({
    this.tokenLogin,
  });

  final String? tokenLogin;
}

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    required this.param,
    this.enabledObsecureText = false,
    super.key,
  });

  final LoginViewParam param;
  final bool enabledObsecureText;

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final FocusNode _focus = FocusNode();
  bool _showPasswordEnabled = true;

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
                  body: SafeArea(
                      child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('asset/image/NO8hx.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Username',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: model.usernameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: 'Masukkan Username',
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: model.passwordController,
                                obscureText: _showPasswordEnabled,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hintText: 'Masukkan Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _showPasswordEnabled
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showPasswordEnabled =
                                            !_showPasswordEnabled;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Spacings.verSpace(20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print(
                                        "${model.usernameController.text} data kode");
                                    print(
                                        "${model.passwordController.text} data sandi");

                                    String usernameText =
                                        model.usernameController.text;
                                    String passwordText =
                                        model.passwordController.text;

                                    if (model.usernameController.text.isEmpty ||
                                        model.passwordController.text.isEmpty) {
                                      return;
                                    }

                                    final bool response =
                                        await model.requestLogin();

                                    if (response && mounted) {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.dashboard,
                                      );
                                    } else {
                                      //TODO: Handle login failed
                                      showErrorToast(
                                          'Username/Password Salah!');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ));
        });
  }

  void showErrorToast(String text) {
    BotToast.showSimpleNotification(
      title: text,
      backgroundColor: Colors.red,
      hideCloseButton: true,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
