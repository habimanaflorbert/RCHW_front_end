import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/models/family.dart';
import 'package:umujyanama/services/village_service.dart';
import 'package:umujyanama/models/village.dart';

class FamilyDetail extends StatefulWidget {
  static const routeName = "/family-detail/";
  final String id;
  const FamilyDetail({super.key, required this.id});

  @override
  State<FamilyDetail> createState() => _FamilyDetailState();
}

class _FamilyDetailState extends State<FamilyDetail> {
  final GlobalKey<FormState> _familyFormKey = GlobalKey<FormState>();
  final FamilyService familyService = FamilyService();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherIdController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherIdController = TextEditingController();
  final TextEditingController _numberKidController = TextEditingController();

  final VillageService villageService = VillageService();
  Family? familyInfo;
  List<Village>? villages;
  String? category;
  String? phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFamilies();
    fetchAllProduct();
  }

  fetchFamilies() async {
    familyInfo =
        await familyService.fetchFamilyInfo(context: context, id: widget.id);
    setState(() {});
  }

  fetchAllProduct() async {
    villages = await villageService.fetchVillages(context: context);
    setState(() {});
  }

  void submitEditFatherName() {
    familyService.editFatherName(
        context: context,
        fatherName: _fatherNameController.text,
        id: widget.id);
  }

  void submitEditFatherIdentification() {
    familyService.editFatherIdentification(
        context: context, fatherId: _fatherIdController.text, id: widget.id);
  }

  void submitEditMotherName() {
    familyService.editMotherName(
        context: context, name: _motherNameController.text, id: widget.id);
  }

  void submitEditMotherId() {
    familyService.editMotherId(
        context: context, motherId: _motherIdController.text, id: widget.id);
  }

  void submitEditChildNumber() {
    familyService.editChildNumber(
        context: context,
        number: int.parse(_numberKidController.text),
        id: widget.id);
  }

  void submitEditPhoneNumber() {
    familyService.editPhoneNumber(
        context: context,
        phone: phoneNumberController.toString(),
        id: widget.id);
  }

  void submitEditVillage() {
    familyService.editVillage(
        context: context, village: category.toString(), id: widget.id);
  }

  void deleteFamily() {
    familyService.deleteFamily(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    _fatherNameController.text = "${familyInfo?.fatherFullName}";
    _fatherIdController.text = "${familyInfo?.fatherIdNo}";
    _motherNameController.text = "${familyInfo?.motherFullName}";
    _motherIdController.text = "${familyInfo?.motherIdNo}";
    _numberKidController.text = "${familyInfo?.numberChild}";
    phoneNumberController = familyInfo?.phoneNumber;
    return familyInfo == null
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
                                              deleteFamily();
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
                              "Father name  ",
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
                                            key: _familyFormKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    controller:
                                                        _fatherNameController,
                                                    hintText: 'Father name',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_familyFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditFatherName();
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
                      Text("${familyInfo?.fatherFullName}",
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
                              "Father Identification  ",
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
                                            key: _familyFormKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextFieldValidation(
                                                    controller:
                                                        _fatherIdController,
                                                    hintText:
                                                        'Father identification',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_familyFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditFatherIdentification();
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
                      Text("${familyInfo?.fatherIdNo}",
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
                              "Mother name  ",
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
                                            key: _familyFormKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    controller:
                                                        _motherNameController,
                                                    hintText: 'Mother name',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_familyFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditMotherName();
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
                      Text("${familyInfo?.motherFullName}",
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
                              "Mother Identification  ",
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
                                            key: _familyFormKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextFieldValidation(
                                                    controller:
                                                        _motherIdController,
                                                    hintText:
                                                        'Mother Identification',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_familyFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditMotherId();
                                                        }
                                                      }),
                                                ]))),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: GlobalVariables.secondaryColor,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${familyInfo?.motherIdNo}",
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Phone number",
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
                                            key: _familyFormKey,
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
                                                    initialValue:
                                                        phoneNumberController,
                                                    onChanged: (phone) {
                                                      // print(phone.completeNumber);
                                                      setState(() {
                                                        print(phone.number);
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
                                                        if (_familyFormKey
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
                      Text("${familyInfo?.phoneNumber}",
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
                              "Number of children",
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
                                            key: _familyFormKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextField(
                                                    type: TextInputType.number,
                                                    controller:
                                                        _numberKidController,
                                                    hintText:
                                                        'Number of children',
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_familyFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditChildNumber();
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
                      Text("${familyInfo?.numberChild}",
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
                              "Village",
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
                                      return villages == null
                                          ? const Loader()
                                          : AlertDialog(
                                              scrollable: true,
                                              content: Form(
                                                  key: _familyFormKey,
                                                  child: Container(
                                                      color: GlobalVariables
                                                          .backgroundColor,
                                                      child: Column(children: [
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: DropdownButton(
                                                            underline:
                                                                Container(), //empty line
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        11,
                                                                        11,
                                                                        11)),
                                                            isExpanded: true,
                                                            hint: const Text(
                                                                "Select village"),
                                                            value: category,
                                                            icon: const Icon(Icons
                                                                .keyboard_arrow_down),
                                                            items: villages!
                                                                .map((item) {
                                                              return DropdownMenuItem(
                                                                  value:
                                                                      item.id,
                                                                  child: Text(
                                                                      "${item.name}-${item.sector}-${item.district}-${item.province}"));
                                                            }).toList(),
                                                            onChanged:
                                                                (newVal) {
                                                              setState(() {
                                                                category =
                                                                    newVal;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        CustomButton(
                                                            text: "Update",
                                                            onTap: () {
                                                              if (_familyFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                submitEditVillage();
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
                      Text("${familyInfo?.villageDetail}",
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
          );
  }
}
