import 'package:bloc_project/core/blocs/dog_images/dog_image_bloc.dart';
import 'package:bloc_project/core/services/dogs_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DogImageBloc _dogImageBloc = DogImageBloc(dogsApiProvider: DogsApiProvider());
  ValueNotifier<bool> isImageLoaded = ValueNotifier<bool>(false);
  late Box dogImagesBox;
  @override
  void initState() {
    _dogImageBloc.add(GetDogImageUrl());

    super.initState();
    createBox();
  }

  void createBox() async {
    dogImagesBox = await Hive.openBox('Dogs Images Database');
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => _dogImageBloc,
      child: BlocListener<DogImageBloc, DogImageState>(
        listener: (context, state) {
          if (state is DogImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  BlocBuilder<DogImageBloc, DogImageState>(
                    builder: (context, state) {
                      if (state is DogImageInitial ||
                          state is DogImageLoading) {
                        return SizedBox(
                          height: screenHeight,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is DogImageLoaded) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              SizedBox(
                                height: screenHeight * 0.5,
                                width: screenWidth * 0.9,
                                child: Image.network(
                                  state.dogImageUrl,
                                  loadingBuilder: (context, child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) =>
                                              isImageLoaded.value = true);
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      }
                      if (state is DogImageError) {
                        return SizedBox(
                          height: screenHeight,
                          child: const Center(
                            child: Text(
                                'oh no there is an error loading the image'),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: BlocBuilder<DogImageBloc, DogImageState>(
              builder: (context, state) {
                return ValueListenableBuilder(
                  valueListenable: isImageLoaded,
                  builder: (context, value, child) {
                    if (value == true) {
                      return FloatingActionButton(
                        onPressed: () async {
                          late final String imageName;
                          if (state is DogImageLoaded) {
                            imageName = path.basename(state.dogImageUrl);
                          }

                          final appDir = await path_provider
                              .getApplicationDocumentsDirectory();
                          dogImagesBox.put(imageName, '$appDir');
                          Navigator.pushNamed(context, '/blog_posts');
                        },
                        child: const Icon(Icons.add),
                      );
                    }
                    return Container();
                  },
                );
              },
            )),
      ),
    );
  }
}
