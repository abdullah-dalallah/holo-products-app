
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/domain/reopistory/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository themeRepository;
  SaveThemeUseCase({required this.themeRepository});

  Future call(ThemeEntity themeEntity) async {
    return await themeRepository.saveTheme(themeEntity);
  }
}