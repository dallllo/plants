
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/features/details/domain/use_cases/details_use_case.dart';
import 'package:plants_app/features/details/presentation/cubit/details_state.dart';

@injectable
class DetailsCubit extends Cubit<DetailsState> {
  final DetailsUseCase _detailsUseCase;

  DetailsCubit(this._detailsUseCase) : super(DetailsInitialState()){
    // getDetailsMethod();
  }

  Future<void> getDetailsMethod(String name) async {
  emit(DetailsInitialState());
    final result = await _detailsUseCase.getDetails(name);
   result.match( 
    (failure) {
        emit(DetailsErrorState(message: failure.message));
      },
      (success) {
        emit(DetailsSuccessState(success));
      },
    );
}
}