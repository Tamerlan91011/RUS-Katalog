import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      colorScheme: const ColorScheme.light(primary: kPrimaryColor, secondary: kPrimaryColor),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => kPrimaryColor),
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(singleSpace * 2)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: const BorderSide(color: kPrimaryColor)))),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
        overlayColor: MaterialStateColor.resolveWith((states) => kPrimaryColor.withOpacity(0.1)),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
          padding: MaterialStateProperty.all(
                const EdgeInsets.all(singleSpace * 2)),
          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2.0, color: kPrimaryColor)),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius))),
        ),
      ),
      toggleableActiveColor: kPrimaryColor,
    );

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: kPrimaryColor,
      colorScheme: const ColorScheme.dark(primary: kPrimaryColor, secondary: kPrimaryColor),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => kPrimaryColor),
            foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
            padding: MaterialStateProperty.all(
                const EdgeInsets.all(singleSpace * 2)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: const BorderSide(color: kPrimaryColor)))),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        overlayColor: MaterialStateColor.resolveWith((states) => kPrimaryColor.withOpacity(0.1)),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
          padding: MaterialStateProperty.all(
                const EdgeInsets.all(singleSpace * 2)),
          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2.0, color: kPrimaryColor)),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius))),
        ),
      ),
      toggleableActiveColor: kPrimaryColor,
    );
