import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:umujyanama/common/widgets/common_drawer.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:umujyanama/auth/services/signup_serveice.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _signupFromKey = GlobalKey<FormState>();
  final SignUpService singUpService = SignUpService();
  String? phoneNumberController;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
  }

  void updateFullName() {
    singUpService.submitFullName(
        context: context, fullName: _firstNameController.text);
  }

  void updateEmail() {
    singUpService.submitEmail(
        context: context, email: _firstNameController.text);
  }

  void updateID() {
    singUpService.submitCard(context: context, id: _firstNameController.text);
  }

  void updatePhone() {
    singUpService.submitPhoneNumber(
        context: context, phoneNumber: _firstNameController.text);
  }

  void updatePassword() {
    singUpService.submitPassword(
        context: context,
        recentPassword: _firstNameController.text,
        newPassword: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "User information",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: GlobalVariables.headText),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                "Full name :   ${user.fullName == '' ? "Unknown" : user.fullName}  ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Form(
                                key: _signupFromKey,
                                child: Container(
                                    color: GlobalVariables.backgroundColor,
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        controller: _firstNameController,
                                        hintText: 'Full Name',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomButton(
                                          text: "Update",
                                          onTap: () {
                                            if (_signupFromKey.currentState!
                                                .validate()) {
                                              updateFullName();
                                            }
                                          }),
                                    ]))),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: GlobalVariables.secondaryColor,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                "Email :  ${user.email == '' ? "Unknown" : user.email} ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Form(
                                key: _signupFromKey,
                                child: Container(
                                    color: GlobalVariables.backgroundColor,
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        controller: _firstNameController,
                                        hintText: 'Email',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomButton(
                                          text: "Update",
                                          onTap: () {
                                            if (_signupFromKey.currentState!
                                                .validate()) {
                                              updateEmail();
                                            }
                                          }),
                                    ]))),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: GlobalVariables.secondaryColor,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                "ID :  ${user.idNumber == '' ? "Unknown" : user.idNumber} ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Form(
                                key: _signupFromKey,
                                child: Container(
                                    color: GlobalVariables.backgroundColor,
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        controller: _firstNameController,
                                        hintText: 'National Identity',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomButton(
                                          text: "Update",
                                          onTap: () {
                                            if (_signupFromKey.currentState!
                                                .validate()) {
                                              updateID();
                                            }
                                          }),
                                    ]))),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: GlobalVariables.secondaryColor,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                "Phone number :   ${user.phoneNumber == '' ? "Unknown" : user.phoneNumber} ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Form(
                                key: _signupFromKey,
                                child: Container(
                                    color: GlobalVariables.backgroundColor,
                                    child: Column(children: [
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
                                            phoneNumberController =
                                                phone.completeNumber;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomButton(
                                          text: "Update",
                                          onTap: () {
                                            if (_signupFromKey.currentState!
                                                .validate()) {
                                              updatePhone();
                                            }
                                          }),
                                    ]))),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: GlobalVariables.secondaryColor,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                "Village :   ${user.village == '' ? "Unknown" : user.village} ",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          child: const Text("Change password",
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.headText)),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    content: Form(
                        key: _signupFromKey,
                        child: Container(
                            color: GlobalVariables.backgroundColor,
                            child: Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: _firstNameController,
                                hintText: 'Recent password',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "New password",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                  text: "Update",
                                  onTap: () {
                                    if (_signupFromKey.currentState!
                                        .validate()) {
                                      updatePassword();
                                    }
                                  }),
                            ]))),
                  );
                });
          },
        ),
      ],
    )));
  }
}
