import 'package:flutter/material.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/home/services/malnutrition_service.dart';
import 'package:umujyanama/models/family.dart';

class MalnutritionScreen extends StatefulWidget {
  const MalnutritionScreen({super.key});

  @override
  State<MalnutritionScreen> createState() => _MalnutritionScreenState();
}

class _MalnutritionScreenState extends State<MalnutritionScreen> {
  final FamilyService familyService = FamilyService();
  final _malnutritionForm = GlobalKey<FormState>();
  final MalnutritionService malnutritionService = MalnutritionService();
  final TextEditingController _fullNameController = TextEditingController();
  List<Family>? families;
  String? family;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchFamilies();
  }

  fetchFamilies() async {
    families = await familyService.fetchFamily(context: context);
    setState(() {});
  }

  void submitMalnutrition() async {
    bool returned = await malnutritionService.submitMalnutrition(
        context: context,
        family: family.toString(),
        childFullName: _fullNameController.text);

    setState(() {
      loading = returned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return families == null
        ? const Loader()
        : Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Record Malnutrition',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _malnutritionForm,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: _fullNameController,
                    hintText: 'Child Full Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      underline: Container(), //empty line
                      style: const TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 11, 11, 11)),
                      hint: const Text('Select any Family',
                          style: TextStyle(fontSize: 15)),
                      isExpanded: true,
                      value: family,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: families!.map((item) {
                        return DropdownMenuItem(
                            value: item.id,
                            child: Text(
                                "${item.fatherFullName} ${item.motherFullName}"));
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          family = newVal!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? CustomButton(text: "Loading...", onTap: () {})
                      : CustomButton(
                          text: "Submit",
                          onTap: () {
                            if (_malnutritionForm.currentState!.validate()) {
                              submitMalnutrition();
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
            )
          ])));
  }
}
