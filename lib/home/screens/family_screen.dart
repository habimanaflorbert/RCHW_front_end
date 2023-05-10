import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/home/services/patient_service.dart';
import 'package:umujyanama/models/village.dart';
import 'package:umujyanama/services/village_service.dart';

class FamilyScreen extends StatefulWidget {
  static const routeName = "/family/";
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  final _patientForm = GlobalKey<FormState>();
  final VillageService villageService = VillageService();
  final FamilyService familyService = FamilyService();

  final TextEditingController _fatherFullNameController =
      TextEditingController();
  final TextEditingController _fatherIdController = TextEditingController();
  final TextEditingController _motherFullNameController =
      TextEditingController();
  final TextEditingController _motherIdController = TextEditingController();
  final TextEditingController _numberKidController = TextEditingController();

  String? phoneNumberController;
  DateTime? dateOfBirth;
  List<Village>? villages;
  String? village;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fatherFullNameController.dispose();
    _fatherIdController.dispose();
    _motherFullNameController.dispose();
    _motherFullNameController.dispose();
    _motherIdController.dispose();
    _numberKidController.dispose();
  }

  void submitFamily() {
    familyService.submitFamily(
        context: context,
        fatherFullName: _fatherFullNameController.text,
        fatherIdNo: _fatherIdController.text,
        motherFullName: _motherFullNameController.text,
        motherIdNo: _motherIdController.text,
        numberChild: int.parse(_numberKidController.text),
        phoneNumber: phoneNumberController.toString(),
        village: village.toString()
        );
  }

  fetchAllProduct() async {
    villages = await villageService.fetchVillages(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return villages == null
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
                                    "Family",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                        ]))),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _patientForm,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _fatherFullNameController,
                          hintText: 'Father name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldValidation(
                          controller: _fatherIdController,
                          hintText: 'Father identification',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _motherFullNameController,
                          hintText: 'Mother name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldValidation(
                          controller: _motherIdController,
                          hintText: 'Mother Identification',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IntlPhoneField(
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'RW',
                          onChanged: (phone) {
                            // print(phone.completeNumber);
                            setState(() {
                              phoneNumberController = phone.completeNumber;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          type: TextInputType.number,
                          controller: _numberKidController,
                          hintText: 'Number of children',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownButton(
                            underline: Container(), //empty line
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 11, 11, 11)),
                            isExpanded: true,
                            hint: const Text("Select village"),
                            value: village,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: villages!.map((item) {
                              return DropdownMenuItem(
                                  value: item.id,
                                  child: Text(
                                      "${item.name}-${item.sector}-${item.district}-${item.province}"));
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                village = newVal;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: "Submit",
                            onTap: () {
                              if (_patientForm.currentState!.validate()) {
                                submitFamily();
                                // signUpUser();
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
