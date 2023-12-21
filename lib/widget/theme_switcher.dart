import 'package:bloc_demo/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitch extends StatelessWidget{
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final icon = state.theme == ThemeMode.system ? Icons.dark_mode : state.theme == ThemeMode.dark ? Icons.light_mode : Icons.brightness_auto;
        final tooltip = state.theme == ThemeMode.system ? "Switch to dark mode" : state.theme == ThemeMode.dark ? "Switch to light mode" : "Switch to system mode";
        return IconButton(
          onPressed: (){
            final event = state.theme == ThemeMode.system ? DarkModeThemeEvent() : state.theme == ThemeMode.dark ? LightModeThemeEvent() : AutoModeThemeEvent();
            context.read<ThemeBloc>().add(event);
          },
          icon: Icon(icon),
          tooltip: tooltip,
        );
      },
    );
  }

}