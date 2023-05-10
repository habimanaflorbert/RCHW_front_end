import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/family_list.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/family.dart';
import 'package:http/http.dart' as http;

class FamilyService {
  void submitFamily(
      {required BuildContext context,
      required String fatherFullName,
      required String fatherIdNo,
      required String motherFullName,
      required String motherIdNo,
      required String phoneNumber,
      required String village,
      required int numberChild}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      Family family = Family(
          fatherFullName: fatherFullName,
          fatherIdNo: fatherIdNo,
          motherFullName: motherFullName,
          motherIdNo: motherIdNo,
          numberChild: numberChild,
          phoneNumber: phoneNumber,
          village: village);

      http.Response resp = await http.post(
        Uri.parse('$uri/api/family/'),
        body: family.toJson(),
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
            Navigator.pop(
                context);
            showSnackbar(context, "Saved successful");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //get families list
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

//get contraception
  Future<Family?> fetchFamilyInfo(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Family? familyInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/family/details/?id=$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            familyInfo = Family.fromJson(jsonEncode(
              jsonDecode(res.body),
            ));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return familyInfo;
  }

//edit father name
  void editFatherName(
      {required BuildContext context,
      required String fatherName,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'father_full_name': fatherName}),
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

//edit father identification
  void editFatherIdentification(
      {required BuildContext context,
      required String fatherId,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'father_id_no': fatherId}),
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

  //edit mother name
  void editMotherName(
      {required BuildContext context,
      required String name,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'mother_full_name': name}),
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

  //edit mother id
  void editMotherId(
      {required BuildContext context,
      required String motherId,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'mother_id_no': motherId}),
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

  //edit children number
  void editChildNumber(
      {required BuildContext context,
      required int number,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'number_child': number}),
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
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'phone_number': phone}),
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

  //edit village
  void editVillage(
      {required BuildContext context,
      required String village,
      required String id}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response response = await http.patch(
        Uri.parse('$uri/api/family/$id/'),
        body: jsonEncode({'village': village}),
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

  Future<Family?> deleteFamily({required context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Family? familyInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.delete(
          Uri.parse("$uri/api/family/delete/?id=$id"),
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
    return familyInfo;
  }
}
