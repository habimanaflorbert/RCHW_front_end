import 'package:flutter/material.dart';
import 'package:umujyanama/auth/screens/sign_in_screen.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/constants/global_variables.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  "Rwanda Community Health Worker",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.secondaryColor),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset("assets/images/1.png"),
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Rwanda community health workers program was established in 1995, aiming at increasing uptake of essential maternal and child clinical services through education of pregnant women and promotion of healthy behaviors and it was linked to the health services.",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              /*  */ CustomButton(
                  text: "Get Started",
                  onTap: () => {
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignInScreen.routeName, (route) => false)
                      }),
                        const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
