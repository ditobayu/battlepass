import 'dart:convert';

import 'package:raion_battlepass/models/sign_in_form_model.dart';
import 'package:raion_battlepass/models/sign_up_form_model.dart';
import 'package:raion_battlepass/models/update_user_form_model.dart';
import 'package:raion_battlepass/models/user_model.dart';
// import 'package:raion_battlepass/models/sign_up_form_model.dart';
// import 'package:raion_battlepass/models/user_model.dart';
import 'package:raion_battlepass/shared/shared_values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel(
          nim: data.nim,
          password: data.password,
        );
        // user = user.copyWith(password: data.password);

        await storeCredentialToLocal(
            jsonDecode(res.body)['token'], data.nim!, data.password!);

        return user;
      } else {
        throw jsonDecode(res.body);
        // throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register(SignUpFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/register'),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel(
          nim: data.nim,
          name: data.name,
          password: data.password,
        );
        // user = user.copyWith(password: data.password);

        // await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body);
        // throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UpdateUserFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('$baseUrl/users'),
        body: data.toJson(),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(
      String token, String nim, String password) async {
    try {
      const storage = FlutterSecureStorage();

      await storage.write(key: 'token', value: token);
      await storage.write(key: 'nim', value: nim);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final res = await http.post(
        Uri.parse(
          '$baseUrl/logout',
        ),
        headers: {
          'Authorization': await getToken(),
        },
      );

      if (res.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final SignInFormModel data = SignInFormModel(
          nim: values['nim'],
          password: values['password'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();

    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();

    await storage.deleteAll();
  }
}
