import 'package:flutter/material.dart';
import 'package:umujyanama/account/screens/edit_account.dart';
import 'package:umujyanama/common/widgets/common_app_bar.dart';
import 'package:umujyanama/common/widgets/common_drawer.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/booked_screen.dart';
import 'package:umujyanama/home/screens/contraception_screen.dart';
import 'package:umujyanama/home/screens/dashoard_screen.dart';
import 'package:umujyanama/home/screens/malnutrition_screen.dart';
import 'package:umujyanama/home/screens/patient_screen.dart';
import 'package:umujyanama/home/services/user_information.dart';
import 'package:umujyanama/models/user.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserInfoService userInfo = UserInfoService();
  User? info;
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const DashboardScreen(),
    const PatientScreen(),
    const MalnutritionScreen(),
    const ContraceptionScreen(),
    const EditAccountScreen()
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    info = await userInfo.fetchUserInfo(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return info != null
        ? const Loader()
        : Scaffold(
            drawer: const CommonDrawer(),
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: GlobalVariables.appBarGradient),
                    ),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  height: 42,
                                  alignment: Alignment.center,
                                  // margin: const EdgeInsets.only(top:10),

                                  child: const Text(
                                    "RHW",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                           Container(
                            color: Colors.transparent,
                            height: 42,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: const Icon(Icons.book),
                              color: Colors.white,
                              onPressed: () {
                          Navigator.pushNamed(context, BookedVillageScreen.routeName);                              
                              },
                            ),
                          )
                        ]))),
            body: pages[_page],
            bottomNavigationBar: BottomNavigationBar(
                onTap: updatePage,
                currentIndex: _page,
                selectedItemColor: GlobalVariables.secondaryColor,
                unselectedItemColor: GlobalVariables.unselectedNavBarColor,
                backgroundColor: GlobalVariables.backgroundColor,
                iconSize: 28,
                items: [
                  BottomNavigationBarItem(
                      icon: Container(
                        width: bottomBarWidth,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: bottomBarBorderWidth,
                                    color: _page == 0
                                        ? GlobalVariables.selectedNavBarColor
                                        : GlobalVariables.backgroundColor))),
                        child: const Icon(Icons.home),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: bottomBarWidth,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: bottomBarBorderWidth,
                                    color: _page == 1
                                        ? GlobalVariables.selectedNavBarColor
                                        : GlobalVariables.backgroundColor))),
                        child: const Icon(Icons.sick),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: bottomBarWidth,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: bottomBarBorderWidth,
                                    color: _page == 2
                                        ? GlobalVariables.selectedNavBarColor
                                        : GlobalVariables.backgroundColor))),
                        child: const Icon(Icons.no_meals),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: bottomBarWidth,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: bottomBarBorderWidth,
                                    color: _page == 3
                                        ? GlobalVariables.selectedNavBarColor
                                        : GlobalVariables.backgroundColor))),
                        child: const Icon(Icons.medical_information),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: bottomBarWidth,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: bottomBarBorderWidth,
                                    color: _page == 4
                                        ? GlobalVariables.selectedNavBarColor
                                        : GlobalVariables.backgroundColor))),
                        child: const Icon(Icons.settings),
                      ),
                      label: ''),
                ]),
          );
  }
}
