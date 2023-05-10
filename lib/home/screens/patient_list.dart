import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';
import "package:moment_dart/moment_dart.dart";
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/features_details/patient_detail.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/home/services/patient_service.dart';
import 'package:umujyanama/models/patient.dart';

class PatientList extends StatefulWidget {
  static const routeName = '/patient-list/';
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final PatientService patientService = PatientService();
  List<Patient>? patients;

  final MomentLocalization localization = MomentLocalizations.fr();

  void navigateToPatientPage(BuildContext context, String id) {
    Navigator.pushNamed(context, PatientDetail.routeName, arguments: id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContraception();
  }

  fetchContraception() async {
    patients = await patientService.fetchMalnutrition(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return patients == null
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
                                    "Patient List",
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
                itemCount: patients!.length,
                itemBuilder: (BuildContext context, int index) {
                  final patientsData = patients![index];
                  return Card(
                    color: Color.fromARGB(66, 201, 201, 201),
                    child: ListTile(
                      leading: const Icon(Icons.list),
                      trailing: Text(
                        Moment(
                          patientsData.createdOn!.toMoment(),
                        ).fromNow(),
                        style:
                            const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(patientsData.fullName,style: const TextStyle(fontWeight: FontWeight.bold),),
                      onTap: () => navigateToPatientPage(
                          context, patientsData.id.toString()),
                    ),
                  );
                }),
          );
  }
}
