import 'package:flutter/material.dart';
import 'package:umujyanama/constants/global_variables.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Container(
                  height: 42,
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.only(top:10),

                  child: const Text(
                    "RHW",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          // Container(
          //   color: Colors.transparent,
          //   height: 42,
          //   margin: const EdgeInsets.symmetric(horizontal: 10),
          //   child: const Icon(
          //     Icons.search_outlined,
          //     color: Colors.white,
          //     size: 25,
          //   ),
          // )
        ]),
      
    );
  }
}
