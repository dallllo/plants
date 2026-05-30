import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_app/core/errors/failure.dart';
import 'package:plants_app/features/details/domain/entities/details_entity.dart';
import 'package:plants_app/features/home/domain/entities/home_entity.dart';
import 'package:plants_app/features/home/domain/use_cases/home_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeIdentifyPlantUseCase identify;
  final HomeGetPlantDetailsUseCase details;

  HomeBloc(this.identify, this.details) : super(InitialHomeState()) {
    on<ScanPlant>((event, emit) async {
      emit(LoadingHomeState());
      final result = await identify.getHomeIdentifyPlant((event.path));


  result.match(
    (l) {
      emit(ErrorHomeState(l));
    },
    (r) {
      emit(PlantLoadedHomeState(r));
    },
  );
      // result.match(
      //   (l) => emit(ErrorHomeState(l)),
      //   (r) => emit(PlantLoadedHomeState(r)),
      // );
    });

    on<PickImagesEvent>((event, emit) async {
      final picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(imageQuality: 50);

      if (images.isNotEmpty) {
        final newPaths = images.map((e) => e.path).take(6).toList();
        emit(HomeStateImageSelected(selectedImages: newPaths));
      }
    });

    on<LoadDetails>((event, emit) async {
      emit(LoadingHomeState());
      final result = await details.getHomeDetailsPlant(event.name);

      // result.match(
      //   (l) => emit(ErrorHomeState(l)),
      //   (r) => emit(DetailsLoadedHomeState(r)),
      // );


  result.match(
    (l) {
      emit(ErrorHomeState(l));
    },
    (r) {
      emit(DetailsLoadedHomeState(r));
    },
  );

    });
  }
}
