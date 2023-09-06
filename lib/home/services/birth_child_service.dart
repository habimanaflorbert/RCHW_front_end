import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:umujyanama/models/birth_child.dart';



class ChildrenService{
    //get malnutrition list
  Future<List<ChildrenBorn>> fetchChildren(
      {required BuildContext context}) async {
    List<ChildrenBorn> childrenList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/child/born/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              childrenList.add(
                ChildrenBorn.fromJson(
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

    return childrenList;
  }
}
