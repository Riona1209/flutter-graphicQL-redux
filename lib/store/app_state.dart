import 'package:flutter/material.dart';

@immutable
class AppState {
  final ThemeData activeTheme;

  AppState({this.activeTheme});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          activeTheme == other.activeTheme;

  @override
  String toString() {
    return 'AppState{activeTheme: ${this.activeTheme}}';
  }
}
