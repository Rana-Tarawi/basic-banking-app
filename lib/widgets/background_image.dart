import 'package:flutter/material.dart';

// ignore: camel_case_types
class backgroundimage extends StatelessWidget {
  final String imageurl;
  const backgroundimage({super.key, required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageurl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
