import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';

abstract class ThemeRepository{
  Future<ThemeEntity> getTheme();
  Future saveTheme(ThemeEntity theme);
}