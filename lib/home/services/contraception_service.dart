import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/contraception.dart';
import 'package:http/http.dart' as http;

class ContraceptionService {
  Future<bool> submitContraception(
      {required BuildContext context,
      required String family,
      required String description}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      Contraception contracep =
          Contraception(family: family, description: description);

      http.Response resp = await http.post(
        Uri.parse('$uri/api/contraception/'),
        body: contracep.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $token'
        },
      );

      // ignore: use_build_context_synchronously
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

//get contraception list
  Future<List<Contraception>> fetchContraception(
      {required BuildContext context}) async {
    List<Contraception> contraceptionList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/contraception/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              contraceptionList.add(
                Contraception.fromJson(
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

    return contraceptionList;
  }

//get contraception
  Future<Contraception?> fetchContraceptionInfo(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Contraception? contraceptionInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/contraception/details/?id=$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            contraceptionInfo = Contraception.fromJson(jsonEncode(
              jsonDecode(res.body),
            ));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return contraceptionInfo;
  }

//edit family

  void editFamily(
      {required BuildContext context,
      required String family,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/contraception/$id/'),
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
  }

  //edit reason

  void editReason(
      {required BuildContext context,
      required String reason,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/contraception/$id/'),
        body: jsonEncode({'description': reason}),
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
  }

// delete contraception

  Future<Contraception?> deleteContraception(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Contraception? contraceptionInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.delete(
          Uri.parse("$uri/api/contraception/delete/?id=$id"),
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
