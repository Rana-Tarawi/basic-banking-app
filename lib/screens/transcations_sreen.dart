// ignore_for_file: camel_case_types

import 'package:basic_banking_app/dataBase.dart';
import 'package:basic_banking_app/screens/home_screen.dart';
import 'package:basic_banking_app/dataUsed/variables.dart';
import 'package:basic_banking_app/widgets/AppBar.dart';
import 'package:basic_banking_app/widgets/background_image.dart';
import 'package:basic_banking_app/widgets/text.dart';
import 'package:flutter/material.dart';

class transctionsScreen extends StatefulWidget {
  const transctionsScreen({super.key});

  @override
  State<transctionsScreen> createState() => _transctionsScreenState();
}

class _transctionsScreenState extends State<transctionsScreen> {
  sqlDb database = sqlDb();
  List transcations = [];

  Future readData() async {
    List<Map> respose = await database.read("transcations");
    transcations.addAll(respose);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar(context, "Transcations History", const homeScreen()),
      body: Stack(children: [
        const backgroundimage(imageurl: "images/otherPages.jpg"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: ListView.builder(
              itemCount: transcations.length,
              itemBuilder: (context, i) {
                int rvsindex = transcations.length - i -1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                      color: black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * .1)),
                      child: SizedBox(
                        width: double.infinity,
                        height: height * 0.15,
                        child: Center(
                            child: ListTile(
                          enabled: false,
                          title: text(
                              txt: "From : ${transcations[rvsindex]['sender']}",
                              size: 20,
                              weight: FontWeight.normal),
                          subtitle: text(
                              txt: "To : ${transcations[rvsindex]['reciever']}",
                              size: 20,
                              weight: FontWeight.normal),
                          trailing: text(
                              txt: "${transcations[rvsindex]['amount']}\$",
                              size: 20,
                              weight: FontWeight.normal),
                          leading: Icon(Icons.sync, color: green),
                        )),
                      )),
                );
              }),
        ),
      ]),
    );
  }
}
