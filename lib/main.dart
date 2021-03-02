import 'package:flutter/material.dart';
import 'package:flutter_graphql/store/app_reducer.dart';
import 'package:flutter_graphql/store/app_state.dart';
import 'package:flutter_graphql/store/theme/theme.dart';
import 'package:redux/redux.dart';


import 'app.dart';

void main() {
  runApp(
    App(
      appKey: Key('__app__'),
      store: Store<AppState>(
        appReducer,
        initialState: AppState(
          activeTheme: Themes.defaultTheme,
        ),
      ),
    ),
  );
}
