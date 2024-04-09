import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/authentication/login.dart';

final sharedPrefProvider = Provider<SharedPreferencesServices>(
  (_) => SharedPreferencesServices(),
);

enum SharedPrefKeys {
  tokenLogin,
}

extension SharedPrefKeysExt on SharedPrefKeys {
  static const Map<SharedPrefKeys, String> _labels = <SharedPrefKeys, String>{
    SharedPrefKeys.tokenLogin: 'token_login',
  };

  String get label => _labels[this] ?? '';
}

class SharedPreferencesServices {
  late SharedPreferences _sharedPreferences;
  bool _ready = false;

  Future<void> _getSharedPreferences() async {
    if (!_ready) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _ready = true;
    }
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<dynamic> get(SharedPrefKeys key) async {
    await _getSharedPreferences();
    switch (key) {
      case SharedPrefKeys.tokenLogin:
        if (_sharedPreferences
                    .getString(SharedPrefKeys.tokenLogin.label)
                    .toString() ==
                'null' ||
            _sharedPreferences.getString(SharedPrefKeys.tokenLogin.label) ==
                null) {
          return null;
        }
        if ((_sharedPreferences.getString(SharedPrefKeys.tokenLogin.label) ??
                '')
            .isNotEmpty) {
          final Map<String, dynamic> response = json.decode(
            _sharedPreferences.getString(key.label) ?? '',
          );
          return LoginResponse.fromJson(response);
        }
        break;
    }
  }

  Future<void> set(SharedPrefKeys key, dynamic value) async {
    await _getSharedPreferences();
    final String jsonString = json.encode(value);

    await _sharedPreferences.setString(key.label, jsonString);
  }

  Future<void> clearStorage() async {
    await _sharedPreferences.clear();
  }
}
