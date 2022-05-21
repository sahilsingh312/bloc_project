part of 'dog_image_bloc.dart';

abstract class DogImageState extends Equatable {
  const DogImageState();

  @override
  List<Object> get props => [];
}

class DogImageInitial extends DogImageState {}

class DogImageLoading extends DogImageState {}

class DogImageLoaded extends DogImageState {
  final String dogImageUrl;
  const DogImageLoaded({
    required this.dogImageUrl,
  });
}

class DogImageError extends DogImageState {
  final String? message;
  const DogImageError(this.message);
}
