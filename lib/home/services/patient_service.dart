import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:umujyanama/constants/global_variables.dart';
import 'package:intl/intl.dart';

class PatientService {
  void submitPatient(
      {required BuildContext context,
      required String fullName,
      required String insuranceName,
      required String insuranceNumber,
      required String sickness,
      required String phoneNumber,
      required DateTime dateOfBirth}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      Patient patient = Patient(
          fullName: fullName,
          insuranceName: insuranceName,
          insuranceNumber: insuranceNumber,
          phoneNumber: phoneNumber,
          sickness: sickness,
          dateOfBirth:"${dateOfBirth.year}-${dateOfBirth.month}-${dateOfBirth.day}"
          );
      http.Response resp = await http.post(
        Uri.parse('$uri/api/patient/'),
        body: patient.toJson(),
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
