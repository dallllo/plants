import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_app/core/extensions/context_extensions.dart';
import 'package:plants_app/core/navigation/routers.dart';
import 'package:plants_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:plants_app/features/home/presentation/widgets/container_items.dart';

class HomeFeatureScreen extends StatelessWidget {
  const HomeFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Home Feature Screen'))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is PlantLoadedHomeState) {
                  context.push(Routes.details, extra: state.plant);
                }

                if (state is ErrorHomeState) {
                  context.showSnackBar(state.failure.message, isError: true);
                }
              },
              builder: (context, state) {
                if (state is LoadingHomeState) {
                  return Center(child: const CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 1000,
                      child: Column(
                        children: [
                          const Gap(10),
                          ElevatedButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final image = await picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 50,
                              );
                              if (image == null) return;
                              context.read<HomeBloc>().add(
                                ScanPlant(image.path),
                              );
                            },
                            child: const Text('Go to Camera'),
                          ),
                          ElevatedButton(
                            onPressed: () => context.read<HomeBloc>().add(
                              PickImagesEvent(),
                            ),
                            child: const Text('Select 6 Images'),
                          ),
                          const Gap(10),

                      
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                if (state is HomeStateImageSelected) {
                                  if (state.selectedImages.isEmpty) {
                                    return const Center(
                                      child: Text("No images selected yet"),
                                    );
                                  }
                                  return GridView.builder(
                                    padding: const EdgeInsets.all(8),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                        ),
                                    itemCount: state.selectedImages.length,
                                    itemBuilder: (context, index) {
                                      final path = state.selectedImages[index];
                                      return ContainerItems(
                                        imageUrl: path,
                                        onTap: () {
                                          context.read<HomeBloc>().add( ScanPlant(path),);
                                        },
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: Text("Select images to display"),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
