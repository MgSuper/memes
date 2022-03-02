import 'package:flutter/material.dart';

const kMyanmarFont = TextStyle(fontSize: 11.0, color: Colors.white);
const kEnglishFont = TextStyle(fontSize: 11.0, color: Colors.white);
const kDefaultLargeText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30.0,
  color: Colors.grey,
  shadows: [
    Shadow(offset: Offset(3, 3), color: Colors.grey, blurRadius: 10.0),
    Shadow(offset: Offset(-3, -3), color: Colors.white, blurRadius: 10.0),
  ],
);

const kDefaultSmallText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
  color: Colors.grey,
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 1.0),
    Shadow(offset: Offset(-1, -1), color: Colors.white, blurRadius: 1.0),
  ],
);
