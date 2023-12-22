import 'package:fake_store_bloc/store/store.dart';
import 'package:fake_store_bloc/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final colorSwatch = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
            title: 'Fake store',
            themeMode: state.theme,
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(Brightness.light),
            darkTheme: _buildTheme(Brightness.dark),
            home: BlocProvider<StoreBloc>(
              create: (context) => StoreBloc(),
              child: const StoreHome(),
            ),
          );
      },
    ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    bool dark = brightness == Brightness.dark;
    Color darkTextColor = Colors.grey;
    var baseTheme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor:Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
      brightness: brightness,
      buttonTheme: ButtonThemeData(
          disabledColor: Colors.grey,
          buttonColor: dark ? darkTextColor : colorSwatch,
          textTheme: ButtonTextTheme.normal
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 14,
          letterSpacing: 1,
          color: dark ? Colors.white54 : null,
        ),
        labelStyle: TextStyle(fontSize: 12,letterSpacing: 1,color: dark ? Colors.white : null),
        contentPadding: const EdgeInsets.only(left: 20,top: 8,bottom: 8,right: 8),
        border: OutlineInputBorder(borderSide: BorderSide(color: dark ? darkTextColor : Colors.black),borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: dark ? darkTextColor : Colors.black),borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: dark ? darkTextColor : Colors.black),borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        suffixIconColor: dark ? darkTextColor : null,
        prefixIconColor: dark ? darkTextColor : null,
      ),

    );
    return baseTheme.copyWith(
        colorScheme: dark ? ColorScheme.dark(brightness: brightness,primary: colorSwatch) : ColorScheme.fromSeed(seedColor: colorSwatch,primary: colorSwatch,onPrimary: colorSwatch,primaryContainer: Colors.grey),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: colorSwatch),
        textSelectionTheme: TextSelectionThemeData(cursorColor:colorSwatch),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: colorSwatch
          ),
        ),
        textTheme: dark ? GoogleFonts.poppinsTextTheme(baseTheme.textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          decorationColor: Colors.white,
        ) : null,
        bottomNavigationBarTheme: dark ? const BottomNavigationBarThemeData(
            selectedItemColor: Colors.white
        ) : null,
        appBarTheme: AppBarTheme(
          backgroundColor: baseTheme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
        )
    );
  }
}
