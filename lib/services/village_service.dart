import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:umujyanama/models/village.dart';
import 'package:umujyanama/provider/user_provider.dart';

import 'package:umujyanama/provider/user_provider.dart';

import '../constants/global_variables.dart';

class VillageService {
  Future<List<Village>> fetchVillages({required BuildContext context}) async {
    List<Village> VillagesList = [];
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/account/villages/"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
       
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              VillagesList.add(
                Village.fromJson(
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
    return VillagesList;
  }
}
