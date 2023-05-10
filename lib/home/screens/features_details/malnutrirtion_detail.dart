import 'package:flutter/material.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/home/services/malnutrition_service.dart';
import 'package:umujyanama/models/contraception.dart';
import 'package:umujyanama/models/family.dart';
import 'package:umujyanama/models/malnutrition.dart';

class MalnutritionDetail extends StatefulWidget {
  static const routeName = "/malnutrition-detail/";
  final String id;

  const MalnutritionDetail({super.key, required this.id});

  @override
  State<MalnutritionDetail> createState() => _MalnutritionDetailState();
}

class _MalnutritionDetailState extends State<MalnutritionDetail> {
  bool _hasMalnutrionOption=true;

  final _malnutritionFromKey = GlobalKey<FormState>();
  final MalnutritionService malnutritionService = MalnutritionService();
  final TextEditingController _childNameController = TextEditingController();
  final FamilyService familyService = FamilyService();
  List<Family>? families;
  bool? malnutrition;
  bool loading = false;

  Malnutrition? contraceptionInfo;
  String? family;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMalnutrition();
    fetchFamilies();
  }

  fetchFamilies() async {
    families = await familyService.fetchFamily(context: context);
  }

  fetchMalnutrition() async {
    contraceptionInfo = await malnutritionService.fetchSingleMalnutrition(
        context: context, id: widget.id);

    setState(() {
      malnutrition = contraceptionInfo!.hasMalnutrition;
    });
  }

  void deleteMalnutrition() {
    malnutritionService.deleteMalnutrition(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    _childNameController.text = "${contraceptionInfo?.childFullName}";
    // print(loading);
    return contraceptionInfo == null
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
                                    "Malnutrition Detail",
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
                                              deleteMalnutrition();
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
                              "Children Name",
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
                                          content: StatefulBuilder(
                                              // You need this, notice the parameters below:
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                            void editChildName() async {
                                              bool dt = await malnutritionService
                                                  .editChildName(
                                                      context: context,
                                                      name: _childNameController
                                                          .text,
                                                      id: widget.id);

                                              setState(() {
                                                loading = dt;
                                              });
                                            }

                                            return Form(
                                                key: _malnutritionFromKey,
                                                child: Container(
                                                    color: GlobalVariables
                                                        .backgroundColor,
                                                    child: Column(children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      CustomTextField(
                                                        controller:
                                                            _childNameController,
                                                        hintText:
                                                            'Child Full Name ',
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      loading
                                                          ? CustomButton(
                                                              text: "Loading..",
                                                              onTap: () {})
                                                          : CustomButton(
                                                              text: "Update",
                                                              onTap: () {
                                                                if (_malnutritionFromKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  editChildName();
                                                                   setState(() {
                                                                  loading =
                                                                      true;
                                                                });
                                                                }
                                                              }),
                                                    ])));
                                          }));
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
                      Text("${contraceptionInfo?.childFullName}",
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
                              "Father and mother  ",
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
                                          content: StatefulBuilder(
                                              // You need this, notice the parameters below:
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                            void submitEditFamily() async {
                                              bool dt =
                                                  await malnutritionService
                                                      .editFamily(
                                                          context: context,
                                                          family:
                                                              family.toString(),
                                                          id: widget.id);

                                              setState(() {
                                                loading = dt;
                                              });
                                            }

                                            return Form(
                                                key: _malnutritionFromKey,
                                                child: Container(
                                                    color: GlobalVariables
                                                        .backgroundColor,
                                                    child: Column(children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: DropdownButton(
                                                          underline:
                                                              Container(), //empty line
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          11,
                                                                          11,
                                                                          11)),
                                                          hint: const Text(
                                                              'Select a Family',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                          isExpanded: true,
                                                          value: family,
                                                          icon: const Icon(Icons
                                                              .keyboard_arrow_down),
                                                          items: families!
                                                              .map((item) {
                                                            return DropdownMenuItem(
                                                                value: item.id,
                                                                child: Text(
                                                                    "${item.fatherFullName} ${item.motherFullName}"));
                                                          }).toList(),
                                                          onChanged:
                                                              (String? newVal) {
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
                                                          ? CustomButton(
                                                              text:
                                                                  "Loading...",
                                                              onTap: () {
                                                                setState(() {
                                                                  loading =
                                                                      false;
                                                                });
                                                              })
                                                          : CustomButton(
                                                              text: "Update",
                                                              onTap: () {
                                                                if (_malnutritionFromKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  submitEditFamily();
                                                                  setState(() {
                                                                    loading =
                                                                        true;
                                                                  });
                                                                }
                                                              })
                                                    ])));
                                          }));
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
                      Text(
                          "${contraceptionInfo?.familyDetail} and ${contraceptionInfo?.motherName}",
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              malnutrition == true
                                  ? "Has malnutrition"
                                  : "No malnutrition ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (
                                      BuildContext context,
                                    ) {
                                      return AlertDialog(
                                          scrollable: true,
                                          content: StatefulBuilder(
                                              // You need this, notice the parameters below:
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                            void submitEditStatus() async {
                                              bool dt =
                                                  await malnutritionService
                                                      .editStatus(
                                                          context: context,
                                                          status:_hasMalnutrionOption,
                                                          id: widget.id);

                                              setState(() {
                                                loading = dt;
                                              });
                                            }

                                            return Form(
                                                key: _malnutritionFromKey,
                                                child: Container(
                                                    color: GlobalVariables
                                                        .backgroundColor,
                                                    child: Column(children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      ListTile(
                                                        title: const Text(
                                                            'Has Malnutrition'),
                                                        leading: Radio(
                                                          value: true,
                                                          activeColor:
                                                              GlobalVariables
                                                                  .secondaryColor,
                                                          groupValue:
                                                              _hasMalnutrionOption,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _hasMalnutrionOption =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: const Text(
                                                            'No Malnutrition'),
                                                        leading: Radio(
                                                          activeColor:
                                                              GlobalVariables
                                                                  .secondaryColor,
                                                          value: false,
                                                          groupValue:
                                                              _hasMalnutrionOption,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _hasMalnutrionOption =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                       loading
                                                          ? CustomButton(
                                                              text:
                                                                  "Loading...",
                                                              onTap: () {
                                                                setState(() {
                                                                  loading =
                                                                      false;
                                                                });
                                                              })
                                                          : CustomButton(
                                                          text: "Update",
                                                          onTap: () {
                                                            if (_malnutritionFromKey
                                                                .currentState!
                                                                .validate()) {
                                                              submitEditStatus();
                                                                setState(() {
                                                                  loading =
                                                                      true;
                                                                });
                                                            }
                                                          }),
                                                    ])));
                                          }));
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
                    ]),
              ),
            ),
          );
  }
}
