import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/auth/screens/sign_in_screen.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/home/screens/contraception_list.dart';
import 'package:umujyanama/home/screens/document.dart';
import 'package:umujyanama/home/screens/family_list.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/home/screens/malnutrition_list.dart';
import 'package:umujyanama/home/screens/patient_list.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.routeName, (route) => false);
    }

    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 240.0,
              decoration: BoxDecoration(
                color: GlobalVariables.secondaryColor,
                boxShadow: [
                  new BoxShadow(blurRadius: 0.0),
                ],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.elliptical(20, 0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

//add family
            ListTile(
              leading: const Icon(
                Icons.family_restroom,
              ),
              title: const Text('add and view Families'),
              onTap: () {
                Navigator.pushNamed(context, FamilyList.routeName);
              },
            ),

//patient section
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.sick,
              ),
              title: const Text('Recorded Patient'),
              onTap: () {
                Navigator.pushNamed(context, PatientList.routeName);
              },
            ),

//malnutrition section
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.no_meals,
              ),
              title: const Text('Recorded Malnutrition'),
              onTap: () {
                Navigator.pushNamed(context, MalnutritionList.routeName);
              },
            ),

//contraception section
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.medical_information,
              ),
              title: const Text('Recorded Contraception'),
              onTap: () {
                Navigator.pushNamed(context, ContraceptionList.routeName);
              },

              
            ),

              ListTile(
              leading: const Icon(
                Icons.document_scanner_outlined,
              ),
              title: const Text('Documentation'),
              onTap: () {
                Navigator.pushNamed(context, DocumentScreen.routeName);
              },

              
            ),

//log out section
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('Are you sure you want logout ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: logOut,
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red[500],
                  ),
                  label: Text(
                    "Log out",
                    style: TextStyle(color: Colors.red[500]),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            ),
          ],
        ));
  }
}
