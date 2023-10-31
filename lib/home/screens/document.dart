import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/features_details/document_details.dart';
import 'package:umujyanama/home/screens/home_screen.dart';
import 'package:umujyanama/home/services/documentation_service.dart';
import 'package:umujyanama/models/document.dart';

class DocumentScreen extends StatefulWidget {
  static const routeName = "/documentation";
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final DocumentService documentService = DocumentService();
  List<Document>? getDocument;

  final MomentLocalization localization = MomentLocalizations.fr();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDocument();
  }

  fetchDocument() async {
    getDocument = await documentService.fetchDocument(context: context);
    setState(() {});
  }


  void navigatePage(BuildContext context, String url) {
    Navigator.pushNamed(context, DocumentDetail.routeName, arguments:url,);
  }

  @override
  Widget build(BuildContext context) {
   
    return getDocument == null
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
                                    "Document List",
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
                itemCount: getDocument!.length,
                itemBuilder: (BuildContext context, int index) {
                  final contraceptionData = getDocument![index];
                  return Card(
                    color: const Color.fromARGB(66, 201, 201, 201),
                    child: ListTile(
                      leading: const Icon(Icons.document_scanner_outlined),
                      trailing: Text(
                        Moment(
                          contraceptionData.createdOn.toMoment(),
                        ).fromNow(),
                        style:
                            const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(
                        contraceptionData.documentName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () =>  navigatePage(
                          context, contraceptionData.documentFile.toString()),
                    ),
                  );
                }),
          );
  }
}
