
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/contraception.dart';
import 'package:http/http.dart' as http;

class ContraceptionService{
  void submitContraception({required BuildContext context,
      required String family,
      required String description
      }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      Contraception contracep=Contraception(family: family,description:description );


 http.Response resp = await http.post(
        Uri.parse('$uri/api/contraception/'),
        body: contracep.toJson(),
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