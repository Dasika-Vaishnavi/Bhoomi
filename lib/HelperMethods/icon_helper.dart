import 'dart:html';

import 'package:flutter/material.dart';

class IconHelper {
  static iconfromImage(ImageProvider<Object> image, double iconSize) {
    return Image(
        image: image,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.scaleDown,
        alignment: FractionalOffset.center);
  }
}
