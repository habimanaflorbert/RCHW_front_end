import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/auth/screens/sign_in_screen.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/constants/location_variables.dart';
import 'package:umujyanama/auth/services/signup_serveice.dart';
import 'package:umujyanama/models/village.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:umujyanama/services/village_service.dart';

class SingUpScreen extends StatefulWidget {
  static const routeName = '/create-account';

  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final VillageService villageService = VillageService();
  List<Village>? villages;
  String? category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProduct();
  }

  String district = 'Gasabo';
  final _signupFromKey = GlobalKey<FormState>();
  final SignUpService singUpService = SignUpService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? phoneNumberController;
  final TextEditingController _nationalIdentity = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _nationalIdentity.dispose();
  }

  void signUpUser() {
    singUpService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
        phoneNumber: phoneNumberController.toString(),
        idNumber: _nationalIdentity.text,
        village: category.toString());

  
  }

  fetchAllProduct() async {
    villages = await villageService.fetchVillages(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return villages == null
        ? const Loader()
        : Scaffold(
            backgroundColor: GlobalVariables.greyBackgroundColor,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Welcome to Create Account ",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.headText),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _signupFromKey,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _fullNameController,
                        hintText: 'Full Name',
                      ),
                      const SizedBox(
                        height: 20,
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
                            phoneNumberController = phone.completeNumber;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _nationalIdentity,
                        hintText: 'National Identity',
                        maxLength: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                                            
                      ),
           
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                          underline: Container(), //empty line
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 11, 11, 11)),
                          isExpanded: true,
                          hint: const Text("Select village"),
                          value: category,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: villages!.map((item) {
                            return DropdownMenuItem(
                                value: item.id, child: Text(item.name));
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              category = newVal;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                              text: "Create Account",
                              onTap: () {
                                if (_signupFromKey.currentState!.validate() &&
                                    phoneNumberController != null) {
                                  signUpUser();
                                
                                }
                              }),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You have already account ?  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    InkWell(
                      child: const Text("Sign in ",
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: GlobalVariables.headText)),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignInScreen.routeName, (route) => false);
                      },
                    ),
                  ],
                ),
              ]),
            ))),
          );
  }
}
