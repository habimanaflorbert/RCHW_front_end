import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/models/document.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/error_handling.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:umujyanama/constants/utils.dart';

class DocumentService {
  //get document list
  Future<List<Document>> fetchDocument({required BuildContext context}) async {
    List<Document> documentList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/document/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              documentList.add(
                Document.fromJson(
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

    return documentList;
  }


}
