import 'package:holo_products_app/features/theme/data/data_source/theme_local_data_source.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/domain/reopistory/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository{

  final ThemeLocalDataSource themeLocalDataSource;
  ThemeRepositoryImpl({required this.themeLocalDataSource});

  @override
  Future<ThemeEntity> getTheme() async{
    return await themeLocalDataSource.getTheme();
  }

  @override
  Future saveTheme(ThemeEntity theme) async{
   return await themeLocalDataSource.saveTheme(theme);
  }

}