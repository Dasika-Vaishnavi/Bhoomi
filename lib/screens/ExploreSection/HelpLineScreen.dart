import 'package:flutter/material.dart';

class HelpLineScreen extends StatefulWidget {
  const HelpLineScreen({Key? key}) : super(key: key);

  @override
  _HelpLineScreenState createState() => _HelpLineScreenState();
}

class _HelpLineScreenState extends State<HelpLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Helpline Numbers"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text("1800-180-1551"),
            )
          ],
        ),
      ),
    );
  }
}
