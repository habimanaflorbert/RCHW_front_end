import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/provider/user_provider.dart';

class SignInService {
  Future<bool> SignInUser(
      {required BuildContext context,
      required String username,
      required String password}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/account/login/'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            // ignore: unused_local_variable
            SharedPreferences pref = await SharedPreferences.getInstance();
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.setUser(res.body);

            await pref.setString(
                'access-token', jsonDecode(res.body)['access']);
            await pref.setString(
                'refresh-token', jsonDecode(res.body)['refresh']);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return false;
  }
}
