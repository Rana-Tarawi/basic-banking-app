// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:basic_banking_app/screens/allCustomers_screen.dart';
import 'package:basic_banking_app/screens/transferTo_screen.dart';
import 'package:basic_banking_app/dataUsed/variables.dart';
import 'package:basic_banking_app/widgets/AppBar.dart';
import 'package:basic_banking_app/widgets/text.dart';
import 'package:flutter/material.dart';
import '../widgets/background_image.dart';

class customerScreen extends StatefulWidget {
  final dta;
  const customerScreen({super.key, required this.dta});

  @override
  State<customerScreen> createState() => _customerScreenState();
}

class _customerScreenState extends State<customerScreen> {
  TextEditingController balance = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar(context, "Customer Profile", const allCustomers()),
      body: Stack(
        children: [
          const backgroundimage(imageurl: "images/otherPages.jpg"),
          Positioned(
            top: height * .15,
            left: width * .03,
            child: CircleAvatar(
              backgroundColor: black,
              radius: width * .15,
              child: Icon(
                Icons.person,
                size: width * .15,
                color: const Color.fromARGB(171, 255, 255, 255),
              ),
            ),
          ),
          Positioned(
              top: height * .35,
              left: width * .05,
              child: SizedBox(
                  height: height * .35,
                  width: width * .9,
                  child: Card(
                    color: black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * .15)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: text(
                                txt: "userName: ${widget.dta['name']}",
                                size: 20,
                                weight: FontWeight.normal),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.email),
                                text(
                                    txt: " Email: ${widget.dta['email']}",
                                    size: 20,
                                    weight: FontWeight.normal),
                              ]),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: text(
                                  txt:
                                      "Current balance: ${widget.dta['balance']}\$",
                                  size: 20,
                                  weight: FontWeight.normal)),
                        ]),
                  ))),
          Positioned(
              top: height * .85,
              left: width * .2,
              child: SizedBox(
                height: height * .08,
                width: width * .6,
                child: ElevatedButton(
                    onPressed: () {
                      transferDialog(context);
                    },
                    child: const text(
                        txt: "Transfer Money",
                        size: 18,
                        weight: FontWeight.bold)),
              ))
        ],
      ),
    );
  }

  Future transferDialog(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            buttonPadding:
                const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            backgroundColor: green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: Form(
              key: formstate,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter an appropriate amount of money !";
                  } else if ((int.parse(value) > widget.dta['balance']) |
                      (value == '0')) {
                    return "Please enter an appropriate amount of money !";
                  }
                  return null;
                },
                controller: balance,
                cursorColor: Colors.white,
                autofocus: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: "Amount of Money",
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  errorMaxLines: 2,
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      child: text(
                          txt: "Transfer", size: 18, weight: FontWeight.bold)),
                  onPressed: () {
                    if (formstate.currentState!.validate()) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => transferToScreen(
                              dta: widget.dta,
                              amount: int.parse(balance.text),
                            ),
                          ),
                          (route) => false);
                    }
                  }),
            ]),
      );
}
