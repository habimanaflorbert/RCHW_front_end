import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:umujyanama/constants/global_variables.dart';
import 'package:umujyanama/constants/loader.dart';
import 'package:umujyanama/home/screens/features_details/booked_details.dart';
import 'package:umujyanama/home/screens/features_details/my_booked_screen.dart';
import 'package:umujyanama/home/services/booking_service.dart';
import 'package:umujyanama/models/booking.dart';

class BookedVillageScreen extends StatefulWidget {
  static const routeName = '/booked-village-list/';
  const BookedVillageScreen({super.key});

  @override
  State<BookedVillageScreen> createState() => _BookedVillageScreenState();
}

class _BookedVillageScreenState extends State<BookedVillageScreen> {
   final BookingService bookingService = BookingService();
  List<Booking>? malnutrition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBooked();
  }

  fetchBooked() async {
    malnutrition =
        await bookingService.bookedVillage(context: context);
    setState(() {});
  }
  void navigateToBookedPage(BuildContext context, String id) {
    Navigator.pushNamed(context, BookedDetailScreen.routeName, arguments: id);
  }


  @override
  Widget build(BuildContext context) {
    return  malnutrition == null
        ? const Loader()
        :  Scaffold(
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
                              "Requested patients",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                    Container(
                      color: Colors.transparent,
                      height: 42,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        icon: const Icon(Icons.list_alt),
                        color: Colors.white,
                        onPressed: () {
                         Navigator.pushNamed(context, MyBookedVillageScreen.routeName); 
                        },
                      ),
                    )
                  ]))),
      body: ListView.builder(
          itemCount: malnutrition!.length,
          itemBuilder: (BuildContext context, int index) {
            final malnutritionData = malnutrition![index];
            return Card(
              color: const Color.fromARGB(66, 201, 201, 201),
              child: ListTile(
                leading: const Icon(Icons.list),
                trailing: Text(
                  Moment(
                    malnutritionData.dateCreated!.toMoment(),
                  ).fromNow(),
                  style: const TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text(
                    "${malnutritionData.fullName} (${malnutritionData.phoneNumber})"),
                onTap: () => navigateToBookedPage(
                    context, malnutritionData.id.toString()),
              ),
            );
          }),
    );
  }
}
