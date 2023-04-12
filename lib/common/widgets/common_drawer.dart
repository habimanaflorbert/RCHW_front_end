import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umujyanama/auth/screens/sign_in_screen.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/home/screens/contraception_list.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    void logOut()async {
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
                height: 280.0,
                decoration: BoxDecoration(
                  color: GlobalVariables.secondaryColor,
                  boxShadow: [
                    new BoxShadow(blurRadius: 0.0),
                  ],
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.elliptical(20, 0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Column(
                      children: [
                      const  SizedBox(height: 80),
                        Text(
                        user.fullName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            



//contraception section

                  const SizedBox(
                    height: 20,
                  ),
         ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('Recorded Contraception'),
            onTap: () {
              Navigator.pop(context, ContraceptionList);
            },
          ),

//log out section


            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton.icon(
                    onPressed:() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                         
                           title: const Text('Logout'),
          content: const Text('Are you sure you want logout ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: logOut,
              child: const Text('OK'),
            ),
          ],);     
                           
                          
                        });
                  },
                              

                    icon: Icon(Icons.logout),
                    label: Text("Log out"),
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
            )
          
          ],
      
      
      )
    );
  }
}
