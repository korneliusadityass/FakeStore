import 'package:appsmobile/core/api/authentication/authentication_api.dart';
import 'package:appsmobile/core/model/authentication/login.dart';
import 'package:appsmobile/core/model/error/error_response.dart';
import 'package:appsmobile/core/services/dio_service.dart';
import 'package:appsmobile/core/util/eror_utils.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';

import '../../services/shared_preferences_services.dart';

final aunthencticationAPI = Provider<AunthencticationAPIServices>((ref) {
  final SharedPreferencesServices sharedPref = ref.read(sharedPrefProvider);
  final DioService dio = ref.read(dioProvider);
  return AunthencticationAPIServices(
    dio.getDio(domainType: DomainType.account),
    sharedPref,
  );
});

class AunthencticationAPIServices {
  AunthencticationAPIServices(
    Dio dio,
    this.sharedPref,
  ) : api = AunthencticationAPI(
          dio,
        );
  final SharedPreferencesServices sharedPref;
  final AunthencticationAPI api;

  Future<Either<Failure, LoginResponse>> login({
    required String username,
    required String password,
  }) async {
    try {
      final payload = UserLogin(username: username, password: password);
      final HttpResponse<dynamic> response = await api.login(
        'application/json',
        payload,
      );
      if (response.isSuccess) {
        return Right<Failure, LoginResponse>(
          LoginResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<LoginResponse>().handleDomainError(
        response,
      );
    } catch (e) {
      return ErrorUtils<LoginResponse>().handleError(e);
    }
  }
}
