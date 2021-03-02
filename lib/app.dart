import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/home_screen.dart';
import 'package:flutter_graphql/screens/settings_screen.dart';
import 'package:flutter_graphql/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';


import 'package:redux/redux.dart';

import 'containers/theme_container.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  final Key appKey;

  App({this.appKey, this.store});
  // render
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: ThemeContainer(builder: (_, ThemeData activeTheme) {
        return MaterialApp(
          theme: activeTheme != null ? activeTheme : ThemeData.dark(),
          routes: {
            '/': (_) => HomeScreen(),
            '/settings': (_) => SettingsScreen(),
          },
        );
      }),
    );
  }
}
