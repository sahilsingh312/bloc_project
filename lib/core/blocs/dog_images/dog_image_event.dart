part of 'dog_image_bloc.dart';

abstract class DogImageEvent extends Equatable {
  const DogImageEvent();

  @override
  List<Object> get props => [];
}

class GetDogImageUrl extends DogImageEvent {}
