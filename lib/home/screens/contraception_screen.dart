import 'package:flutter/material.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/contraception_service.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/models/family.dart';

class ContraceptionScreen extends StatefulWidget {
  const ContraceptionScreen({super.key});

  @override
  State<ContraceptionScreen> createState() => _ContraceptionScreenState();
}

class _ContraceptionScreenState extends State<ContraceptionScreen> {
  final ContraceptionService contraceptionService = ContraceptionService();
  final FamilyService familyService = FamilyService();
  List<Family>? families;

  final _contraceptionForm = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  String? family;
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }


  void submitMalnutrition() {
    contraceptionService.submitContraception(
        context: context,
        family: family.toString(),
        description: _descriptionController.text);
    
  }

  @override
  Widget build(BuildContext context) {
    return families == null
        ? const Loader()
        :Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              'Record Contraception',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _contraceptionForm,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    underline: Container(), //empty line
                    style: const TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 11, 11, 11)),
                    hint: const Text('Select a Family',
                        style: TextStyle(fontSize: 15)),
                    isExpanded: true,
                    value: family,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: families!.map((item) {
                      return DropdownMenuItem(
                          value: item.id,
                          child:  Text(
                                "${item.fatherFullName} ${item.motherFullName}"));
                      }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        family = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: "Description",
                  maxLines: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Submit",
                    onTap: () {
                      if (_contraceptionForm.currentState!.validate()) {
                        submitMalnutrition();
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
          )
        ],
      ),
    ));
  }
}


