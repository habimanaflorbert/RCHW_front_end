import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import "package:moment_dart/moment_dart.dart";
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/family_screen.dart';
import 'package:umujyanama/home/screens/features_details/family_details.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/models/family.dart';

class FamilyList extends StatefulWidget {
  static const routeName = '/families/';
  const FamilyList({super.key});

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  final FamilyService familyService = FamilyService();
  List<Family>? families;

  final MomentLocalization localization = MomentLocalizations.fr();

  void navigateToFamilyPage(BuildContext context, String id) {
    Navigator.pushNamed(context, FamilyDetail.routeName, arguments: id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContraception();
  }

  fetchContraception() async {
    families = await familyService.fetchFamily(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return families == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
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
                                    "Families List",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                          Container(
                            color: Colors.transparent,
                            height: 42,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context,
                                    FamilyScreen.routeName);
                              },
                            ),
                          )
                        ]))),
            body: ListView.builder(
                itemCount: families!.length,
                itemBuilder: (BuildContext context, int index) {
                  final familyData = families![index];
                
                  return Card(
                    color: Color.fromARGB(66, 201, 201, 201),
                    child: ListTile(
                      iconColor: GlobalVariables.selectedNavBarColor,
                      selectedColor: GlobalVariables.backgroundColor,
                      leading: const Icon(Icons.family_restroom_outlined),
                      trailing: Text(
                          familyData.numberChild.toString(),
                        style: const TextStyle(color: Colors.green, fontSize: 15,fontWeight: FontWeight.bold)
                        ),
                      
                      title: Text(
                          "${familyData.fatherFullName} and ${familyData.motherFullName} (${familyData.villageDetail}) ",style: const TextStyle(fontWeight: FontWeight.bold),),
                      onTap: () => navigateToFamilyPage(
                          context, familyData.id.toString()),
                    ),
                  );
                }),
          );
  }
}
