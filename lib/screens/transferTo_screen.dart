// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:basic_banking_app/dataUsed/allcustomers_data.dart';
import 'package:basic_banking_app/dataBase.dart';
import 'package:basic_banking_app/screens/customer_screen.dart';
import 'package:basic_banking_app/screens/home_screen.dart';
import 'package:basic_banking_app/widgets/AppBar.dart';
import 'package:basic_banking_app/widgets/text.dart';
import 'package:flutter/material.dart';
import '../dataUsed/variables.dart';
import '../widgets/background_image.dart';

class transferToScreen extends StatefulWidget {
  final dta;
  final int amount;

  const transferToScreen({super.key, required this.dta, required this.amount});

  @override
  State<transferToScreen> createState() => _transferToScreenState();
}

class _transferToScreenState extends State<transferToScreen> {
  int recieverID = -1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    sqlDb database = sqlDb();
    int senderID = widget.dta['id'];


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar(context, "Transfer to", customerScreen(dta: widget.dta)),
      body: Stack(children: [
        const backgroundimage(imageurl: "images/otherPages.jpg"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
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
                            title: text(
                                txt: "${data[i]['name']}",
                                size: 20,
                                weight: FontWeight.normal),
                            subtitle: text(
                                txt: "${data[i]['email']}",
                                size: 20,
                                weight: FontWeight.normal),
                            trailing: text(
                                txt: "${data[i]['balance']}\$",
                                size: 20,
                                weight: FontWeight.normal),
                            leading: Icon(
                              Icons.check_circle,
                              color: recieverID == data[i]['id']
                                  ? green
                                  : const Color.fromARGB(255, 114, 114, 114),
                              size: 30,
                            ),
                            onTap: () async {
                              setState(() {
                                recieverID = data[i]['id'];
                                allcustomers[i]['balance'] =
                                    int.parse('${allcustomers[i]['balance']}') +
                                        widget.amount;
                                allcustomers[senderID - 1]
                                    ['balance'] = int.parse(
                                        '${allcustomers[senderID - 1]['balance']}') -
                                    widget.amount;
                              });
                              int response1 = await database.update(
                                "customers",
                                allcustomers[i],
                                'id= $recieverID',
                              );
                              int response2 = await database.update("customers",
                                  allcustomers[senderID - 1], 'id= $senderID');
                              int response3 =
                                  await database.insert("transcations", {
                                'sender':
                                    '${allcustomers[senderID - 1]['name']}',
                                'reciever': '${allcustomers[i]['name']}',
                                'amount': widget.amount
                              });
                              if ((response1 != 0) &
                                  (response2 != 0) &
                                  (response3 != 0)) {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) =>
                                            const homeScreen()),
                                    );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                'images/successMessage.jpg')),
                                        Text("   Success !",
                                            style: TextStyle(
                                                color: green,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ));
                              }
                            },
                          )))),
                );
              }),
        ),
      ]),
    );
  }
}
