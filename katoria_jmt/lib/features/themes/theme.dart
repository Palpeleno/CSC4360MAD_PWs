import 'package:flutter/material.dart';
import 'package:katoria_jmt/common/color_extension.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
    colorScheme: ColorScheme.light(
    background: TColor.lightGreen,
    primary: TColor.primaryBeta,
    secondary: TColor.secondaryBeta,
    onBackground: Color.fromARGB(255, 235, 249, 232),
    onSurface: TColor.tertiaryText,

  )
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.blueGrey,
    primary: Color.fromARGB(255, 113, 116, 111),
    secondary: Color.fromARGB(255, 3, 55, 11),
    onBackground: Colors.black,
    onSurface: TColor.primaryText,
    
  )
);
