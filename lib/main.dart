import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:umujyanama/router.dart';
import 'package:umujyanama/welcome/screens/welcome_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    setState(() {
      token = p.getString('access-token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RCHW',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: token != null ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
