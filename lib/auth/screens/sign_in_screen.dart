import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:umujyanama/auth/screens/sign_up_screen.dart';
import 'package:umujyanama/auth/services/signin_service.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/login';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool loading = false;
  final _signInFormKey = GlobalKey<FormState>();
  final SignInService signInService = SignInService();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameController;
  SharedPreferences? p;
  String? token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  signInUser() async {
    bool returned = await signInService.SignInUser(
        context: context,
        username: _usernameController.toString(),
        password: _passwordController.text);
    setState(() {
      loading = returned;
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(children: [
                      const SizedBox(
                        height: 40,
                      ),
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'RW',
                        onChanged: (phone) {
                          // print(phone.completeNumber);
                          setState(() {
                            _usernameController = phone.completeNumber;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        autoCorrect: false,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      loading
                          ? CustomButton(text: "loading...", onTap: () {})
                          : CustomButton(
                              text: "Sign in",
                              onTap: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                  setState(() {
                                    loading = true;
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
                    Expanded(
                      child: InkWell(
                        child: const Text("Create account ",
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: GlobalVariables.headText)),
                        onTap: () {
                          Navigator.pushNamed(context, SingUpScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ))),
          );
  }
}
