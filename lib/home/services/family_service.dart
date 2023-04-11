import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/models/family.dart';
import 'package:http/http.dart' as http;

class FamilyService {
  Future<List<Family>> fetchFamily({required BuildContext context}) async {
    List<Family> familyList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/family/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
    httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
    
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              familyList.add(
                Family.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });

    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return familyList;
  }
}
