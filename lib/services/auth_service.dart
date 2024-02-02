import 'dart:convert';

import 'package:raion_battlepass/models/sign_up_form_model.dart';
// import 'package:raion_battlepass/models/user_model.dart';
import 'package:raion_battlepass/shared/shared_values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> login(SignUpFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        // UserModel user = UserModel.fromJson(
        //   jsonDecode(res.body.data),
        // );
        // user = user.copyWith(password: data.password);

// Map<String, dynamic> json = jsonDecode(res.body);
        await storeCredentialToLocal(jsonDecode(res.body)['token'], data);

        return true;
      } else {
        throw jsonDecode(res.body);
        // throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(
      String token, SignUpFormModel data) async {
    try {
      const storage = FlutterSecureStorage();

      await storage.write(key: 'token', value: token);
      await storage.write(key: 'nim', value: data.nim);
      await storage.write(key: 'password', value: data.password);
    } catch (e) {
      rethrow;
    }
  }
}
