import 'package:flutter/material.dart';
import 'package:flutter_graphql/store/app_state.dart';
import 'package:flutter_graphql/store/theme/theme.dart';
import 'package:flutter_graphql/store/theme/theme_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SettingsScreen extends StatelessWidget {
  // render
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (_, vm) {
          return Scaffold(
            backgroundColor: vm.activeTheme.backgroundColor,
            appBar: AppBar(
              title: Text(
                'Settings',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ListView.builder(
                itemCount: ThemeTypes.values.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Themes.getTheme(ThemeTypes.values[index])
                              .primaryColor,
                          Themes.getTheme(ThemeTypes.values[index]).accentColor,
                          Themes.getTheme(ThemeTypes.values[index])
                              .backgroundColor,
                        ],
                        stops: [.5, 1, 0],
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        Themes.getThemeName(ThemeTypes.values[index]),
                        style: TextStyle(
                          color: Themes.getTheme(ThemeTypes.values[index])
                              .accentColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        vm.onThemeChanged(ThemeTypes.values[index]);
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),
          );
        });
  }
}

class _ViewModel {
  final Function onThemeChanged;
  final ThemeData activeTheme;

  _ViewModel({
    @required this.activeTheme,
    @required this.onThemeChanged,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTheme: store.state.activeTheme,
      onThemeChanged: (ThemeTypes updateType) => store.dispatch(
        ChangeThemeAction(updateType),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          activeTheme == other.activeTheme;

  @override
  int get hashCode => activeTheme.hashCode;
}
