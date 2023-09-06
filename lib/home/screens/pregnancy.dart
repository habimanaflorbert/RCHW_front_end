import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/pregnancy_service.dart';
import 'package:umujyanama/models/pregnancy.dart';

class PregnancyScreen extends StatefulWidget {
  static const routeName = "/pregnancy";
  const PregnancyScreen({super.key});

  @override
  State<PregnancyScreen> createState() => _PregnancyScreenState();
}

class _PregnancyScreenState extends State<PregnancyScreen> {
  final PregnancyService familyService = PregnancyService();
  List<Pregnancy>? pregnancies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPregnancy();
  }

  fetchPregnancy() async {
    pregnancies = await familyService.fetchPregnancy(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return pregnancies == null
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
                                    "Pragnancy List Assigned",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                         
                        ]))),
            body: ListView.builder(
                itemCount: pregnancies!.length,
                itemBuilder: (BuildContext context, int index) {
                  final familyData = pregnancies![index];

                  return Card(
                    color: const Color.fromARGB(66, 201, 201, 201),
                    child: ListTile(
                      iconColor: GlobalVariables.selectedNavBarColor,
                      selectedColor: GlobalVariables.backgroundColor,
                      leading: const Icon(Icons.pregnant_woman),
                      title: Text(
                        "${familyData.fullName.toString()}\n${familyData.village} \nPhone : ${familyData.phone}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: null,
                    ),
                  );
                }),
          );
  }
}
