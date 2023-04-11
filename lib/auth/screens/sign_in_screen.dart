import 'package:flutter/material.dart';
import 'package:umujyanama/auth/screens/sign_up_screen.dart';
import 'package:umujyanama/auth/services/signin_service.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/home/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/login';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool name = false;
  final _signInFormKey = GlobalKey<FormState>();
  final SignInService signInService = SignInService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  signInUser() async {
    signInService.SignInUser(
        context: context,
        username: _usernameController.text,
        password: _passwordController.text);
    name = await signInService.is_load;

    if (name == false) {
      setState(() {
        name = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(children: [
        const SizedBox(
            height: 60,
          ),
          const Text(
            "Welcome to Login",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: GlobalVariables.headText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          Form(
            key: _signInFormKey,
            child: Container(
              padding:const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Column(children: [
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  controller: _usernameController,
                  hintText: 'username',
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                    text: name ? "loading ... " : "Sign in",
                    onTap: () {
                      if (_signInFormKey.currentState!.validate()) {
                        signInUser();
                        setState(() {
                          name = true;
                        });
                      }
                    }),
                const SizedBox(
                  height: 40,
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You don't have account ?  ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              InkWell(
                child: const Text("Create account ",
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.headText)),
                onTap: () {
                  Navigator.pushNamed(context, SingUpScreen.routeName);
                },
              ),
            ],
          ),
        ]),
      ))),
    );
  }
}
