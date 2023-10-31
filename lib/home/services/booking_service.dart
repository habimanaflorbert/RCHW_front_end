
import 'dart:convert';

import 'package:umujyanama/constants/error_handling.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/utils.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/models/booking.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';


class BookingService{
  //get booked village list
  Future<List<Booking>> bookedVillage({required BuildContext context}) async {
    List<Booking> bookingList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/booking/booked_village/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              bookingList.add(
                Booking.fromJson(
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

    return bookingList;
  }

    //get my booked list
  Future<List<Booking>> myBooked({required BuildContext context}) async {
    List<Booking> bookedList = [];
    try {
      final pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('access-token');
      http.Response res = await http.get(Uri.parse("$uri/api/booking/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              bookedList.add(
                Booking.fromJson(
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

    return bookedList;
  }

//get booked
  Future<Booking?> fetchInfo(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
    Booking? bookInfo;
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/booking/request_detail/?id=$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            bookInfo = Booking.fromJson(jsonEncode(
              jsonDecode(res.body),
            ));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return bookInfo;
  }



//get visted
  Future<bool?>  visited(
      {required BuildContext context, required String id}) async {
    final pref = await SharedPreferences.getInstance();
   
    final String? token = pref.getString('access-token');
    try {
      http.Response res = await http.patch(
          Uri.parse("$uri/api/booking/$id/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'JWT $token'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
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

}