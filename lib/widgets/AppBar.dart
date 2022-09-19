import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appbar(context, String title,Widget popup) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
        title: Text(
          title,
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.chevron_back,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => popup,));
          },
        )),
  );
}
