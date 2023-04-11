import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/malnutrition.dart';
import 'package:http/http.dart' as http;

class MalnutritionService {
  void submitMalnutrition(
      {required BuildContext context,
      required String family,
      required String childFullName}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');

     Malnutrition malnutrition= Malnutrition(family: family, childFullName: childFullName);
       
       
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
      print(e);
      showSnackbar(context, e.toString());
    }
  }
}
