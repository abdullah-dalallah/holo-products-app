import 'package:holo_products_app/core/usecases/usecase.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/domain/reopistory/theme_repository.dart';

class GetThemeUseCase {
  final ThemeRepository themeRepository;
  GetThemeUseCase({required this.themeRepository});

  Future<ThemeEntity> call(NoParams params) async {
    return await themeRepository.getTheme();
  }

}