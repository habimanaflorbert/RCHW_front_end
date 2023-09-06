import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/birth_child_service.dart';
import 'package:umujyanama/models/birth_child.dart';

class ChildrenScreen extends StatefulWidget {
  static const routeName = "/children";
  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  final ChildrenService childrenService = ChildrenService();
  List<ChildrenBorn>? children;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPregnancy();
  }

  fetchPregnancy() async {
    children = await childrenService.fetchChildren(context: context);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return  children == null
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
                                    "Children List assigned",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                         
                        ]))),
            body: ListView.builder(
                itemCount: children!.length,
                itemBuilder: (BuildContext context, int index) {
                  final familyData = children![index];

                  return Card(
                    color: Color.fromARGB(66, 255, 253, 253),
                    child: ListTile(
                      iconColor: GlobalVariables.selectedNavBarColor,
                      selectedColor: GlobalVariables.backgroundColor,
                      leading: const Icon(Icons.child_care),
                   
                      title: Text(
                        "Child Name: ${familyData.fullName.toString()} \nFamily: ${familyData.fatherFullName} -${familyData.motherFullName} (${familyData.village})",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: null,
                    ),
                  );
                }),
          );
  }
}
