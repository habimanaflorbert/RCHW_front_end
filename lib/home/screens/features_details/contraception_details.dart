import 'package:flutter/material.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/common/widgets/custom_textfield.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/contraception_service.dart';
import 'package:umujyanama/home/services/family_service.dart';
import 'package:umujyanama/models/contraception.dart';
import 'package:umujyanama/models/family.dart';

class ContraceptionDetail extends StatefulWidget {
  static const routeName = "/contraception-detail/";
  final String id;
  const ContraceptionDetail({super.key, required this.id});

  @override
  State<ContraceptionDetail> createState() => _ContraceptionDetailState();
}

class _ContraceptionDetailState extends State<ContraceptionDetail> {
  final ContraceptionService contraceptionService = ContraceptionService();
  final _contraceptionFromKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FamilyService familyService = FamilyService();
  List<Family>? families;

  Contraception? contraceptionInfo;
  String? family;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchContraception();
    fetchFamilies();
  }

  fetchFamilies() async {
    families = await familyService.fetchFamily(context: context);
    setState(() {});
  }

  fetchContraception() async {
    contraceptionInfo = await contraceptionService.fetchContraceptionInfo(
        context: context, id: widget.id);
    setState(() {});
  }

  void submitEditFamily() {
    contraceptionService.editFamily(
        context: context, family: family.toString(), id: widget.id);
  }

  void submitEditReason() {
    contraceptionService.editReason(
        context: context, reason: _nameController.text, id: widget.id);
  }

  void deleteContraception() {
    contraceptionService.deleteContraception(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
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
                                              deleteContraception();
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
                              "Family  ",
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
                                            key: _contraceptionFromKey,
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
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromARGB(
                                                              255, 11, 11, 11)),
                                                      hint: const Text(
                                                          'Select a Family',
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                      isExpanded: true,
                                                      value: family,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items:
                                                          families!.map((item) {
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
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_contraceptionFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditFamily();
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
                      Text(
                          "${contraceptionInfo?.familyDetail} and ${contraceptionInfo?.motherNames}",
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
                              "Reason  ",
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
                                            key: _contraceptionFromKey,
                                            child: Container(
                                                color: GlobalVariables
                                                    .backgroundColor,
                                                child: Column(children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CustomTextFieldLong(
                                                    controller: _nameController,
                                                    hintText: "Description",
                                                    maxLength: 10,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  CustomButton(
                                                      text: "Update",
                                                      onTap: () {
                                                        if (_contraceptionFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          submitEditReason();
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
                      Text("${contraceptionInfo?.description}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AutofillHints.transactionCurrency)),
                    ]),
              ),
            ),
          );
  }
}
