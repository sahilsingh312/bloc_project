import 'package:bloc_project/core/services/dogs_api_provider.dart';

class DogApiRepository {
  final _dogImageProvider = DogsApiProvider();
  Future<String> fetchDogImageUrl() => _dogImageProvider.fetchUrl();
}

class NetworkError extends Error {}
