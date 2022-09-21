// ignore_for_file: camel_case_types

import 'package:basic_banking_app/dataBase.dart';
import 'package:basic_banking_app/screens/customer_screen.dart';
import 'package:basic_banking_app/screens/home_screen.dart';
import 'package:basic_banking_app/widgets/AppBar.dart';
import 'package:basic_banking_app/widgets/text.dart';
import 'package:flutter/material.dart';
import '../dataUsed/variables.dart';
import '../widgets/background_image.dart';

class allCustomers extends StatefulWidget {
  const allCustomers({super.key});

  @override
  State<allCustomers> createState() => _allCustomersState();
}

class _allCustomersState extends State<allCustomers> {
  sqlDb database = sqlDb();
  Future readData() async {
    List<Map> respose = await database.read("customers");
    data = [];
    data.addAll(respose);
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
      appBar: appbar(context, "All Customers",const homeScreen()),
      body: Stack(
        children: [
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
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => customerScreen(
                                dta: data[i],
                              )));
                          },
                          title: text(
                              txt: '${data[i]['name']}',
                              size: 20,
                              weight: FontWeight.normal),
                          subtitle: text(
                              txt: '${data[i]['email']}',
                              size: 20,
                              weight: FontWeight.normal),
                          trailing: text(
                              txt: '${data[i]['balance']}\$',
                              size: 20,
                              weight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
