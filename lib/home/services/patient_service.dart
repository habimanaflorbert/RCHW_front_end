import 'dart:convert';

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
  Future<bool> submitPatient(
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
          dateOfBirth:
              "${dateOfBirth.year}-${dateOfBirth.month}-${dateOfBirth.day}");
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
      showSnackbar(context, e.toString());
    }
    return false;
  }

  //get patients
  Future<List<Patient>> fetchMalnutrition(
      {required BuildContext context}) async {
    List<Patient> patientList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/patient/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              patientList.add(
                Patient.fromJson(
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
    return patientList;
  }

//get patient
  Future<Patient?> fetchPatientInfo(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Patient? patientInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/patient/details/?id=$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            patientInfo = Patient.fromJson(jsonEncode(
              jsonDecode(res.body),
            ));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return patientInfo;
  }

  //edit full name
  void editFullName(
      {required BuildContext context,
      required String fullName,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/patient/$id/'),
        body: jsonEncode({'full_name': fullName}),
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

  //edit phone number
  void editPhoneNumber(
      {required BuildContext context,
      required String phone,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/patient/$id/'),
        body: jsonEncode({'phone': phone}),
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

  // edit insurance Name
  void editInsuranceName(
      {required BuildContext context,
      required String insuranceName,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/patient/$id/'),
        body: jsonEncode({'insurance_name': insuranceName}),
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

  // edit  insurance number
  void editInsuranceNumber(
      {required BuildContext context,
      required String insuranceNumber,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/patient/$id/'),
        body: jsonEncode({'insurance_number': insuranceNumber}),
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

  // edit sickness
  void editSickness(
      {required BuildContext context,
      required String sickness,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/patient/$id/'),
        body: jsonEncode({'sickness': sickness}),
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

  // edit date of birth
  void editDOB(
      {required BuildContext context,
      required DateTime dateOfBirth,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/patient/$id/'),
        body: jsonEncode({
          'date_of_birth':
              "${dateOfBirth.year}-${dateOfBirth.month}-${dateOfBirth.day}"
        }),
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

  // delete Patient

  Future<Patient?> deletePatient(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Patient? patientInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.delete(
          Uri.parse("$uri/api/patient/delete/?id=$id"),
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
    return patientInfo;
  }
}
