import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future saveTheme(ThemeEntity theme);
  Future<ThemeEntity> getTheme();
}

const CACHED_THEME = 'CACHED_THEME';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource{
  final SharedPreferences sharedPreferences;
  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ThemeEntity> getTheme() async {
    var themeValue = sharedPreferences.get(CACHED_THEME);
    if(themeValue == 'dark'){
      return ThemeEntity(themeType: ThemeType.dark);
    }
    return ThemeEntity(themeType: ThemeType.light);
  }

  @override
  Future saveTheme(ThemeEntity theme) async {
    var themeValue = theme.themeType == ThemeType.dark ? 'dark' : 'light';
    await sharedPreferences.setString(CACHED_THEME, themeValue);
  }
}
