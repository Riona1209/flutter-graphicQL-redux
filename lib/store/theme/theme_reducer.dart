import 'package:flutter/material.dart';
import 'package:flutter_graphql/store/theme/theme.dart';
import 'package:redux/redux.dart';

class ChangeThemeAction {
  final ThemeTypes updateTheme;

  ChangeThemeAction(this.updateTheme);

  @override
  String toString() {
    return 'ChangeThemeAction ${this.updateTheme}';
  }
}

final themeReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, ChangeThemeAction>(_changeTheme),
]);

ThemeData _changeTheme(ThemeData theme, ChangeThemeAction action) {
  return Themes.getTheme(action.updateTheme);
}
