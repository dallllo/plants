import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:plants_app/features/details/presentation/cubit/details_cubit.dart';
import 'package:plants_app/features/details/presentation/cubit/details_state.dart';
import 'package:plants_app/features/home/domain/entities/home_entity.dart';

class DetailsFeatureScreen extends StatelessWidget {
  final HomeEntity extra;
  const DetailsFeatureScreen({super.key, required this.extra});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plant Details"), centerTitle:true),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsInitialState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is DetailsSuccessState) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(
                      File(extra.imageUrl),
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                    // Icon(Icons.error_outline, size: 100,),
                    Gap(20),
                    Text(state.data.name, style: TextStyle(fontSize: 22)),
                    Gap(10),
                    Text(
                      state.data.description,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    Gap(8),
                    Text(
                      "Accuracy: ${(extra.score! * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is DetailsErrorState) {
            return Scaffold(
              body: Center(
                child: Column(children: [Gap(10), Text(state.message)]),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
