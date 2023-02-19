import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeData = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontFamily: "Jannah",
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16)),
  primarySwatch: Colors.pink,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.pink[300],
    iconSize: 27,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.pink,
    elevation: 20,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black, size: 30),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 27,
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
  ),
);

TextStyle black10bold() => TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black12bold() => TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black14bold() => TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black16bold() => TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black18bold() => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
TextStyle black20bold() => TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );

TextStyle black10regular() => TextStyle(
      fontSize: 10.0,
    );
TextStyle black12regular() => TextStyle(
      fontSize: 12.0,
    );
TextStyle black14regular() => TextStyle(
      fontSize: 14.0,
    );
TextStyle black16regular() => TextStyle(
      fontSize: 16.0,
    );
TextStyle black18regular() => TextStyle(
      fontSize: 18.0,
    );
TextStyle black20regular() => TextStyle(
      fontSize: 20.0,
    );

TextStyle white10bold() => TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white12bold() => TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white14bold() => TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white16bold() => TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white18bold() => TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
TextStyle white20bold() => TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

TextStyle white10regular() => TextStyle(
      fontSize: 10.0,
      color: Colors.white,
    );
TextStyle white12regular() => TextStyle(
      fontSize: 12.0,
      color: Colors.white,
    );
TextStyle white14regular() => TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    );
TextStyle white16regular() => TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    );
TextStyle white18regular() => TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    );
TextStyle white20regular() => TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    );
