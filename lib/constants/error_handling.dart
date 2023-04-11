import 'dart:convert';

import 'package:umujyanama/constants/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      if (jsonDecode(response.body)['phone_number']!=null) {

      showSnackbar(context, "Phone number is already exist");

      } else if (jsonDecode(response.body)['email']!=null) {

      showSnackbar(context, "Email is already exist");

      }

      showSnackbar(context, jsonDecode(response.body));
      break;

    case 500:
      showSnackbar(context, jsonDecode(response.body));
      break;

    default:
      showSnackbar(context, response.body);
  }
}
