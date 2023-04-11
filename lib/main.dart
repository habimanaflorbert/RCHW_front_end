import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:umujyanama/router.dart';
import 'package:umujyanama/services/village_service.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      home: const WelcomeScreen(),
    );
  }
}
