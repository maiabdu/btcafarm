import 'package:flutter/material.dart';

class Mnemomic extends StatefulWidget {
  final String mnemomic;
  const Mnemomic({Key? key, required this.mnemomic}) : super(key: key);

  @override
  State<Mnemomic> createState() => _MnemomicState();
}

class _MnemomicState extends State<Mnemomic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: Text(widget.mnemomic)),
      ),
    );
  }
}
