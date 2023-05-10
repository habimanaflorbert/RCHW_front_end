import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import "package:moment_dart/moment_dart.dart";
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/features_details/malnutrirtion_detail.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/home/services/malnutrition_service.dart';
import 'package:umujyanama/models/malnutrition.dart';

class MalnutritionList extends StatefulWidget {
  static const routeName = '/malnutrition-list/';
  const MalnutritionList({super.key});

  @override
  State<MalnutritionList> createState() => _MalnutritionListState();
}

class _MalnutritionListState extends State<MalnutritionList> {
  final MalnutritionService malnutritionService = MalnutritionService();
  List<Malnutrition>? malnutrition;

  final MomentLocalization localization = MomentLocalizations.fr();

  void navigateToMalnutritionPage(BuildContext context, String id) {
    Navigator.pushNamed(context, MalnutritionDetail.routeName, arguments: id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContraception();
  }

  fetchContraception() async {
    malnutrition =
        await malnutritionService.fetchMalnutrition(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return malnutrition == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
                preferredSize:const Size.fromHeight(60),
                child: AppBar(
                    flexibleSpace: Container(
                      decoration:const BoxDecoration(
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
                                    "Malnutrition List",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                          Container(
                            color: Colors.transparent,
                            height: 42,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon:const Icon(Icons.house),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    HomeScreen.routeName, (route) => false);
                              },
                            ),
                          )
                        ]))),
            body: ListView.builder(
                itemCount: malnutrition!.length,
                itemBuilder: (BuildContext context, int index) {
                  final malnutritionData = malnutrition![index];
                  return Card(
                     color:const Color.fromARGB(66, 201, 201, 201),
                    child: ListTile(
                      leading: const Icon(Icons.list),
                      trailing: Text(
                        Moment(malnutritionData.createdOn!.toMoment(),)
                            .fromNow(),
                        style: const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(
                          "${malnutritionData.childFullName} (${malnutritionData.familyVillage})"),
                      onTap: () => navigateToMalnutritionPage(
                          context, malnutritionData.id.toString()),
                    ),
                  );
                }),
          );
  }
}
