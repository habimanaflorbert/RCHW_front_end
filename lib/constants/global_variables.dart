import 'package:flutter/material.dart';

String uri = 'https://eb99-196-12-131-142.ngrok-free.app';

class GlobalVariables {
// users types
  static const String admin = 'admin';
  static const String user = 'user';

  //colors
  static const appBarGradient = LinearGradient(
    colors: [Color.fromARGB(255, 11, 129, 5), Color.fromARGB(255, 36, 133, 6)],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 22, 88, 7);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color.fromARGB(255, 227, 227, 227);
  static const selectedNavBarColor = Color.fromARGB(255, 7, 101, 29);
  static const unselectedNavBarColor = Colors.black87;
  static const headText = Color.fromARGB(255, 22, 88, 7);
  static const containerColor = Color.fromARGB(255, 17, 63, 3);
}
