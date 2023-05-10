import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/features_details/malnutrirtion_detail.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/malnutrition.dart';
import 'package:http/http.dart' as http;

class MalnutritionService {
  Future<bool> submitMalnutrition(
      {required BuildContext context,
      required String family,
      required String childFullName}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');

      Malnutrition malnutrition =
          Malnutrition(family: family, childFullName: childFullName);

      http.Response resp = await http.post(
        Uri.parse('$uri/api/malnutrition/'),
        body: malnutrition.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );

      httpErrorHandle(
          response: resp,
          context: context,
          onSuccess: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
            showSnackbar(context, "Saved successful");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return false;
  }

  //get malnutrition list
  Future<List<Malnutrition>> fetchMalnutrition(
      {required BuildContext context}) async {
    List<Malnutrition> malnutritionList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/malnutrition/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              malnutritionList.add(
                Malnutrition.fromJson(
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

    return malnutritionList;
  }

  //get malnutrition
  Future<Malnutrition?> fetchSingleMalnutrition(
      {required BuildContext context, required String id}) async {
    Malnutrition? malnutritionInfo;
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(
          Uri.parse("$uri/api/malnutrition/details/?id=$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            malnutritionInfo = Malnutrition.fromJson(jsonEncode(
              jsonDecode(res.body),
            ));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }

    return malnutritionInfo;
  }

  // edit date of birth
  Future<bool> editChildName(
      {required BuildContext context,
      required String name,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/malnutrition/$id/'),
        body: jsonEncode({'child_full_name': name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
            showSnackbar(context, "Updated successful");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return false;
  }

//edit family
  Future<bool> editFamily(
      {required BuildContext context,
      required String family,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/malnutrition/$id/'),
        body: jsonEncode({'family': family}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
            showSnackbar(context, "Updated successful");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    // Navigator.of(context).pop();
    return false;
  }

//edit family
  Future<bool> editStatus(
      {required BuildContext context,
      required bool status,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/malnutrition/$id/'),
        body: jsonEncode({'has_malnutrition': status}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
            showSnackbar(context, "Updated successful");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    // Navigator.of(context).pop();
    return false;
  }
  // delete Malnutrition

  Future<Malnutrition?> deleteMalnutrition(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Malnutrition? contraceptionInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.delete(
          Uri.parse("$uri/api/malnutrition/delete/?id=$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            Navigator.pop(context);
            showSnackbar(context, "Deleted successful");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return contraceptionInfo;
  }
}
