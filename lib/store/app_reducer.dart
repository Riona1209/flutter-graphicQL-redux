
import 'package:flutter_graphql/store/theme/theme_reducer.dart';

import 'app_state.dart';
AppState appReducer(AppState state, action) {
  return AppState(
    activeTheme: themeReducer(state.activeTheme, action),
  );
}
