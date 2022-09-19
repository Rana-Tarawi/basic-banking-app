// ignore_for_file: camel_case_types

import 'package:basic_banking_app/screens/allCustomers_screen.dart';
import 'package:basic_banking_app/screens/transcations_sreen.dart';
import 'package:basic_banking_app/dataUsed/variables.dart';
import 'package:basic_banking_app/widgets/text.dart';
import 'package:flutter/material.dart';
import '../widgets/background_image.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        const backgroundimage(imageurl: 'images/homePage.jpg'),
        SizedBox(
          width: width,
          height: height,
          child: CustomPaint(painter: mypaint()),
        ),
        Positioned(
          top: width * 0.45,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text(
                    txt: "Banking app",
                    size: width * .07,
                    weight: FontWeight.bold),
                const SizedBox(height: 15),
                text(
                    txt: "for your effortless",
                    size: width * .07,
                    weight: FontWeight.bold),
                const SizedBox(height: 15),
                text(
                    txt: " money management",
                    size: width * .07,
                    weight: FontWeight.bold),
              ]),
        ),
        Positioned(
            top: height * .7,
            left: width * .38,
            child: SizedBox(
                height: height * .08,
                width: width * .6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const allCustomers(),
                        ),
                        (route) => false);
                  },
                  child: const Center(
                      child: text(
                          txt: "View all Customers",
                          size: 18,
                          weight: FontWeight.bold)),
                ))),
        Positioned(
            top: height * .8,
            left: width * .38,
            child: SizedBox(
                height: height * .08,
                width: width * .6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const transctionsScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Center(
                      child: text(
                          txt: "Transcations History",
                          size: 18,
                          weight: FontWeight.bold)),
                ))),
      ]),
    );
  }
}

class mypaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = black;
    final arc = Path();
    arc.moveTo(0, 0);
    arc.arcToPoint(
      Offset(0, size.height * .75),
      radius: Radius.circular(size.width * .3),
      clockwise: true,
    );
    canvas.drawPath(arc, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
