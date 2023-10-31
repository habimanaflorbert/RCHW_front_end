import 'package:flutter/material.dart';
import 'package:umujyanama/common/widgets/custom_button.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/services/booking_service.dart';
import 'package:umujyanama/models/booking.dart';

class BookedDetailScreen extends StatefulWidget {
  static const routeName = "/booked-detail/";
  final String id;
  const BookedDetailScreen({super.key, required this.id});

  @override
  State<BookedDetailScreen> createState() => _BookedDetailScreenState();
}

class _BookedDetailScreenState extends State<BookedDetailScreen> {
  bool loading=false;
  final BookingService bookedService = BookingService();
  Booking? booked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAllProduct();
  }

  fetchAllProduct() async {
    booked = await bookedService.fetchInfo(context: context, id: widget.id);
    setState(() {});
  }

  void submitEditFamily() {
    bookedService.visited(context: context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return booked == null
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
                                    "Patient requested details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                        ]))),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Expanded(
                        child: Text(
                          "Full name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${booked?.fullName}",
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Expanded(
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${booked?.phoneNumber}",
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Expanded(
                        child: Text(
                          "Village Located",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${booked?.villageDetailName}",
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Expanded(
                        child: Text(
                          "Sympthomes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ]),
                     const SizedBox(
                      height: 10,
                    ),
                    Text("${booked?.description}",
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                      loading
                          ? CustomButton(text: "loading...", onTap: () {})
                          : CustomButton(
                              text: "Visit",
                              onTap: () {
                               
                                  submitEditFamily();
                                  setState(() {
                                    loading = true;
                                  });
                                })
                              ,
                  ],
                ),
              ),
            ),
          );
  }
}
