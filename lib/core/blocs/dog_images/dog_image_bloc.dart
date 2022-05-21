import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/services/dogs_api_provider.dart';
import 'package:equatable/equatable.dart';

import '../../repository/dog_api_repository.dart';

part 'dog_image_event.dart';
part 'dog_image_state.dart';

class DogImageBloc extends Bloc<DogImageEvent, DogImageState> {
  final DogsApiProvider dogsApiProvider;

  DogImageBloc({required DogsApiProvider dogsApiProvider})
      : dogsApiProvider = dogsApiProvider ,
        super(DogImageInitial()) {
    on<GetDogImageUrl>((event, emit) async {
      try {
        emit(DogImageLoading());
        final myUrl = await dogsApiProvider.fetchUrl();
        emit(DogImageLoaded(dogImageUrl: myUrl));
        if (myUrl.isEmpty) {
          emit(DogImageError(myUrl));
        }
        if (myUrl.contains('.mp4')) {
          emit(const DogImageError('sorry this is a video. Try again'));
        }
      } on NetworkError {
        emit(const DogImageError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
