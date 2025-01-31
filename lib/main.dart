import 'package:flutter/material.dart';

import 'screen/homepage.dart';

void main() {
  runApp(MyStat());
}

class MyStat extends StatefulWidget {
  @override
  State<MyStat> createState() => _MyStat();
}

class _MyStat extends State<MyStat> {
  @override
  Widget build(BuildContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
