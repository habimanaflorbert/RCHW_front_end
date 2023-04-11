import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
      backgroundColor: Colors.white,
      child: Scaffold(
        body: Wrap(
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton.icon(
                    onPressed: null,
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
        ),
        bottomNavigationBar: Container(
          height: 40.0,
          color: GlobalVariables.secondaryColor,
          child: const Center(
            child: Text(
              "@copyright RCHW",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
