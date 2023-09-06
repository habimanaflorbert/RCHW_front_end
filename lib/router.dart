import 'package:flutter/material.dart';
import 'package:umujyanama/auth/screens/sign_in_screen.dart';
import 'package:umujyanama/auth/screens/sign_up_screen.dart';
import 'package:umujyanama/home/screens/children_screen.dart';
import 'package:umujyanama/home/screens/contraception_list.dart';
import 'package:umujyanama/home/screens/document.dart';
import 'package:umujyanama/home/screens/family_list.dart';
import 'package:umujyanama/home/screens/family_screen.dart';
import 'package:umujyanama/home/screens/features_details/contraception_details.dart';
import 'package:umujyanama/home/screens/features_details/document_details.dart';
import 'package:umujyanama/home/screens/features_details/family_details.dart';
import 'package:umujyanama/home/screens/features_details/malnutrirtion_detail.dart';
import 'package:umujyanama/home/screens/features_details/patient_detail.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/home/screens/malnutrition_list.dart';
import 'package:umujyanama/home/screens/patient_list.dart';
import 'package:umujyanama/home/screens/pregnancy.dart';
import 'package:umujyanama/welcome/screens/page_not_found.dart';
import 'package:umujyanama/welcome/screens/welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const WelcomeScreen());
    case SignInScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignInScreen());
    case SingUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SingUpScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case ContraceptionList.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ContraceptionList());

    case ContraceptionDetail.routeName:
      var id = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ContraceptionDetail(id: id));

    case FamilyList.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const FamilyList());

    case FamilyScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const FamilyScreen());

    case FamilyDetail.routeName:
      var id = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => FamilyDetail(id: id));

    case MalnutritionList.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const MalnutritionList());

    case PatientList.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PatientList());

    case PatientDetail.routeName:
      var id = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => PatientDetail(id: id));
   
    case MalnutritionDetail.routeName:
      var id = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => MalnutritionDetail(id: id));
    
    case DocumentScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const DocumentScreen());
    
      case PregnancyScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PregnancyScreen());

      case ChildrenScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ChildrenScreen());

    case DocumentDetail.routeName:
      var url = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => DocumentDetail(documentUrl: url));
    

    default:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PageNotFound());
  }
}
