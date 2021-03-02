import 'package:flutter/material.dart';
import 'package:flutter_graphql/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ThemeContainer extends StatelessWidget {
  final ViewModelBuilder<ThemeData> builder;

  ThemeContainer({Key key, @required this.builder}) : super(key: key);

  // render
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ThemeData>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.activeTheme,
      builder: builder,
    );
  }
}
