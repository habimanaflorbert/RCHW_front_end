import 'package:flutter/material.dart';
import 'package:umujyanama/auth/screens/sign_in_screen.dart';
import 'package:umujyanama/auth/screens/sign_up_screen.dart';
import 'package:umujyanama/home/screens/contraception_list.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/welcome/screens/page_not_found.dart';
import 'package:umujyanama/welcome/screens/welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const WelcomeScreen()
          );
    case SignInScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SignInScreen()
          );
    case SingUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SingUpScreen()
          );

      case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HomeScreen()
          );

      case ContraceptionList.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ContraceptionList()
          );
   
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:(_)=> const PageNotFound()
        );
  }
}
