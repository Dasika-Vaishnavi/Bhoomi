import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/enums.dart';

class CustomText extends StatefulWidget {
  String text;
  TextStyle? style;

  CustomText(
    this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    String text1 = widget.text;
    final translator = GoogleTranslator();
    Languagechosen languagechosen =
        Provider.of<AppData>(context, listen: false).languagechosen!;
    switch (languagechosen) {
      case Languagechosen.english:
        {
          text1 = widget.text;
          break;
        }
      case Languagechosen.hindi:
        {
          translator.translate(widget.text, to: "hi").then((value) {
            setState(() {
              text1 = value.text;
            });
          });
          break;
        }
      case Languagechosen.telgu:
        {
          translator.translate(widget.text, to: "te").then((value) {
            setState(() {
              text1 = value.text;
            });
          });
          break;
        }
    }

    return Text(
      text1,
      style: widget.style,
    );
  }
}
