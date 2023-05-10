import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/patient_service.dart';
import 'package:umujyanama/models/patient.dart';
import 'package:umujyanama/services/village_service.dart';

class PatientDetail extends StatefulWidget {
  static const routeName = "/patient-detail/";
  final String id;
  const PatientDetail({super.key, required this.id});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  final _patientFromKey = GlobalKey<FormState>();
  final PatientService patientService = PatientService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _insuranceNameController =
      TextEditingController();
  final TextEditingController _insuranceNumberController =
      TextEditingController();
  final TextEditingController _nationIdentificationController =
      TextEditingController();
  final TextEditingController _sicknessController = TextEditingController();
  final VillageService villageService = VillageService();

  Patient? patientInfo;
  String? category;
  String? phoneNumberController;
  DateTime? dateOfBirth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPatient();
    // fetchFamilies();
  }


  fetchPatient() async {
    patientInfo =
        await patientService.fetchPatientInfo(context: context, id: widget.id);
    setState(() {});
  }

  void submitEditFullName() {
    patientService.editFullName(
        context: context, fullName: _fullNameController.text, id: widget.id);
  }

  void submitEditPhoneNumber() {
    patientService.editPhoneNumber(
        context: context, phone: phoneNumberController.toString(), id: widget.id);
  }

void submitEditInsuranceName() {
    patientService.editInsuranceName(
        context: context, insuranceName: _insuranceNameController.text, id: widget.id);
  }

void submitEditInsuranceNumber() {
    patientService.editInsuranceNumber(
        context: context, insuranceNumber: _insuranceNumberController.text, id: widget.id);
  }

  void submitEditSickness() {
    patientService.editSickness(
        context: context, sickness: _sicknessController.text, id: widget.id);
  }

    void submitEditDBO() {
    patientService.editDOB(
        context: context, dateOfBirth:dateOfBirth!, id: widget.id);
  }

  void deletePatient() {
    patientService.deletePatient(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // if(patientInfo!= null){
    //     setState(() {
    _fullNameController.text = "${patientInfo?.fullName}";
    _insuranceNameController.text = "${patientInfo?.insuranceName}";
    _insuranceNumberController.text = "${patientInfo?.insuranceNumber}";
    _sicknessController.text = "${patientInfo?.sickness}";
   phoneNumberController = patientInfo?.phoneNumber;
    

    return  patientInfo == null
        ? const Loader()
        :Scaffold(
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
                                    "Patient Detail",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                          Container(
                            color: Colors.transparent,
                            height: 42,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: const Icon(Icons.delete_forever_outlined),
                              color: Colors.red[500],
                              iconSize: 35,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Alert'),
                                        content: const Text(
                                            'Are you sure you want delete ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deletePatient();
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          )
                        ]))),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Full Name  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Form(
                                            key: _patientFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    controller:
                                                        _fullNameController,
                                                    hintText: 'Full Name',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_patientFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditFullName();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${patientInfo?.fullName}",
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Form(
                                            key: _patientFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  IntlPhoneField(
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Phone Number',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(),
                                                      ),
                                                    ),
                                                    initialCountryCode: 'RW',
                                                    initialValue:phoneNumberController,
                                                    onChanged: (phone) {
                                                      // print(phone.completeNumber);
                                                      setState(() {
                                                        phoneNumberController =
                                                            phone.number;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_patientFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditPhoneNumber();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${patientInfo?.phoneNumber}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AutofillHints.transactionCurrency)),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Insurance Name  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Form(
                                            key: _patientFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    controller:
                                                        _insuranceNameController,
                                                    hintText: 'Insurance Name',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_patientFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditInsuranceName();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${patientInfo?.insuranceName}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AutofillHints.transactionCurrency)),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Insurance Number  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Form(
                                            key: _patientFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    controller:
                                                        _insuranceNumberController,
                                                    hintText:
                                                        'Insurance Number',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_patientFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditInsuranceNumber();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${patientInfo?.insuranceNumber}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AutofillHints.transactionCurrency)),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Sickness  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Form(
                                            key: _patientFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    controller:
                                                        _sicknessController,
                                                    hintText: 'Sickness',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_patientFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditSickness();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${patientInfo?.sickness}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AutofillHints.transactionCurrency)),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Date of birth  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Form(
                                            key: _patientFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  DateTimeFormField(
                                                    
                                                    decoration:
                                                        const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.black45),
                                                      errorStyle: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                      border:
                                                          OutlineInputBorder(),
                                                      suffixIcon: Icon(
                                                          Icons.event_note),
                                                      labelText:
                                                          'Date of birth',
                                                    ),
                                                    initialValue: DateTime.parse(patientInfo!.dateOfBirth),
                                                    mode:
                                                        DateTimeFieldPickerMode
                                                            .date,
                                                    autovalidateMode:
                                                        AutovalidateMode.always,
                                                    validator: (e) => (e?.day ??
                                                                0) ==
                                                            1
                                                        ? 'Please not the first day'
                                                        : null,
                                                    
                                                    onDateSelected:
                                                        (DateTime value) {
                                                     
                                                      setState(() {
                                                        dateOfBirth = value;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_patientFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditDBO();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${patientInfo?.dateOfBirth}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AutofillHints.transactionCurrency)),
                    ]),
              ),
            ),
          );
  }
}
