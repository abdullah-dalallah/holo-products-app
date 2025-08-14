import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holo_products_app/core/usecases/usecase.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/domain/usecases/get_theme_use_case.dart';
import 'package:holo_products_app/features/theme/domain/usecases/save_theme_use_case.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.saveThemeUseCase,required this.getThemeUseCase}) : super(ThemeState.initial()) {
    on<GetTheme>(onGetThemeEvent);
    on<ToggleTheme>(onToggleTheme);

  }
  Future onGetThemeEvent(GetTheme event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: ThemeStatus.loading));
    try{
      var result = await getThemeUseCase(NoParams());
      emit(state.copyWith(status: ThemeStatus.success, themeEntity: result));
    }
    catch (e){
      emit(state.copyWith(status: ThemeStatus.error, errorMessage: e.toString ()));
    }
}


  Future onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async{
    if(state.themeEntity!=null){
      var newThemeType = state. themeEntity!.themeType == ThemeType.dark ? ThemeType. light : ThemeType. dark;
      var newThemeEntity = ThemeEntity(themeType: newThemeType);
      try {
        await saveThemeUseCase (newThemeEntity);
        emit(state.copyWith(
            status: ThemeStatus.success, themeEntity: newThemeEntity));
      }
      catch(e){
        emit(state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()));
      }
    }

  }

  }