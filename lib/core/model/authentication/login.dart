import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class UserLogin {
  UserLogin({
    required this.username,
    required this.password,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);

  final String username;
  final String password;
}

@JsonSerializable()
class LoginResponse {
  LoginResponse({
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  final String token;
}
