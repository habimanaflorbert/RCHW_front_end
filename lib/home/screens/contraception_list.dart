import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import "package:moment_dart/moment_dart.dart";
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/features_details/contraception_details.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/home/services/contraception_service.dart';
import 'package:umujyanama/models/contraception.dart';

class ContraceptionList extends StatefulWidget {
  static const routeName = '/contraception';
  const ContraceptionList({super.key});

  @override
  State<ContraceptionList> createState() => _ContraceptionListState();
}

class _ContraceptionListState extends State<ContraceptionList> {
  final ContraceptionService contraceptionService = ContraceptionService();
  List<Contraception>? contraceptions;

  final MomentLocalization localization = MomentLocalizations.fr();

  void navigateToContraceptionPage(BuildContext context, String id) {
    Navigator.pushNamed(context, ContraceptionDetail.routeName, arguments: id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContraception();
  }

  fetchContraception() async {
    contraceptions =
        await contraceptionService.fetchContraception(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return contraceptions == null
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
                                    "Contraception List",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                          Container(
                            color: Colors.transparent,
                            height: 42,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: const Icon(Icons.house),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    HomeScreen.routeName, (route) => false);
                              },
                            ),
                          )
                        ]))),
            body: ListView.builder(
                itemCount: contraceptions!.length,
                itemBuilder: (BuildContext context, int index) {
                  final contraceptionData = contraceptions![index];
                  return Card(
                    color: Color.fromARGB(66, 201, 201, 201),
                    child: ListTile(
                      leading: const Icon(Icons.list),
                      trailing: Text(
                        Moment(
                          contraceptionData.createdOn!.toMoment(),
                        ).fromNow(),
                        style:
                            const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(
                          "${contraceptionData.familyDetail} and ${contraceptionData.motherNames}",style: const TextStyle(fontWeight: FontWeight.bold),),
                      onTap: () => navigateToContraceptionPage(
                          context, contraceptionData.id.toString()),
                    ),
                  );
                }),
          );
  }
}
