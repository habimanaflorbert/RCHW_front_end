import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:date_field/date_field.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/home/services/patient_service.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final _patientForm = GlobalKey<FormState>();
  final PatientService patientService = PatientService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _insuranceNameController =
      TextEditingController();
  final TextEditingController _insuranceNumberController =
      TextEditingController();
  final TextEditingController _sicknessController = TextEditingController();
  final TextEditingController _nationalIdentity = TextEditingController();

  String? phoneNumberController;
  DateTime? dateOfBirth;
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _insuranceNameController.dispose();
    _sicknessController.dispose();
  }

  void submitPatient() async {
    bool dt = await patientService.submitPatient(
        context: context,
        fullName: _fullNameController.text,
        phoneNumber: phoneNumberController.toString(),
        insuranceName: _insuranceNameController.text,
        insuranceNumber: _insuranceNumberController.text,
        sickness: _sicknessController.text,
        dateOfBirth: dateOfBirth!);
    setState(() {
      loading = dt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Record Patient',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    controller: _fullNameController,
                    hintText: 'Full Name',
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
                    controller: _insuranceNameController,
                    hintText: 'Insurance Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldValidation(
                    controller: _insuranceNumberController,
                    hintText: 'Insurance Number',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: _sicknessController,
                    hintText: 'Sickness',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Date of birth',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        dateOfBirth = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? CustomButton(text: "loading...", onTap: () {})
                      : CustomButton(
                          text: "Submit",
                          onTap: () {
                            if (_patientForm.currentState!.validate()) {
                              submitPatient();
                              setState(() {
                                loading = true;
                              });
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
