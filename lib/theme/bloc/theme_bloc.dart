
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<DarkModeThemeEvent>((event, emit) {
      emit(ThemeState(theme: ThemeMode.dark));
    });
    on<LightModeThemeEvent>((event, emit) {
      emit(ThemeState(theme: ThemeMode.light));
    });
    on<AutoModeThemeEvent>((event, emit) {
      emit(ThemeState(theme: ThemeMode.system));
    });
  }
}
