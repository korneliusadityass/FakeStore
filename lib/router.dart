import 'package:appsmobile/core/app_constants/route.dart';
import 'package:appsmobile/ui/views/detail/detail_view.dart';
import 'package:appsmobile/ui/views/home/dashboard_view.dart';
import 'package:flutter/material.dart';

import 'ui/views/authentication/login_view.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    MaterialPageRoute<T>? buildRoute<T>({
      required Widget Function(BuildContext) builder,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<T>(
        settings: settings,
        builder: builder,
        fullscreenDialog: fullscreenDialog,
      );
    }

    bool argsIsInvalid = false;

    switch (settings.name) {
      case Routes.login:
        final LoginViewParam param = settings.arguments is LoginViewParam
            ? settings.arguments as LoginViewParam
            : LoginViewParam();
        return buildRoute(
          builder: (_) => LoginView(
            param: param,
          ),
        );
      case Routes.dashboard:
        return buildRoute(
          builder: (_) => const Home(),
        );
      case Routes.detailPage:
        DetailProductParam param = DetailProductParam(mode: 'view', id: 0);
        if (settings.arguments is DetailProductParam) {
          param = settings.arguments as DetailProductParam;
        } else {
          argsIsInvalid = true;
          // continue invalidArgs;
        }

        return buildRoute(
          builder: (_) => DetailProduct(
            param: param,
          ),
        );
      default:
        return null;
    }
  }
}
