import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:umujyanama/models/user.dart';
import 'package:umujyanama/provider/user_provider.dart';

import 'package:umujyanama/constants/global_variables.dart';

class UserInfoService {
  Future<User?> fetchUserInfo({required BuildContext context}) async {
    final pref = await SharedPreferences.getInstance();
    User? userInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.get(Uri.parse("$uri/account/user_me/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.setUser(res.body);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return userInfo;
  }

}
