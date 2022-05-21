import 'package:bloc_project/core/blocs/dog_images/dog_image_bloc.dart';
import 'package:bloc_project/core/services/dogs_api_provider.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dog_images_test.mocks.dart';

var mockDogsApiProvider = MockDogsApiProvider();
@GenerateMocks([DogsApiProvider])
Future<void> main() async {
  group('Dog Images Bloc', () {
    blocTest(
      'Checking for Api call',
      build: () {
        when(mockDogsApiProvider.fetchUrl()).thenAnswer((_) async => 'url');
        final bloc = DogImageBloc(dogsApiProvider: mockDogsApiProvider);
        bloc.add(GetDogImageUrl());
        return bloc;
      },
      expect: () => [
        DogImageLoading(),
        const DogImageLoaded(
            dogImageUrl:
                'https://random.dog/e561e443-34ad-4ba2-8fad-a9cc9df4cdc5.jpg'),
      ],
      setUp: () {},
    );
  });
}
