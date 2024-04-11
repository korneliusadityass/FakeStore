import 'dart:io';

import 'package:appsmobile/core/model/authentication/login.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AunthencticationAPI {
  factory AunthencticationAPI(Dio dio, {String baseUrl}) = _AunthencticationAPI;

  @POST('auth/login')
  Future<HttpResponse<dynamic>> login(
    @Header('Accept') String accept,
    @Body() UserLogin payload,
  );
}
