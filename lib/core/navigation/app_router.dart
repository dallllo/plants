import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/features/details/presentation/cubit/details_cubit.dart';
import 'package:plants_app/features/details/presentation/pages/details_feature_screen.dart';
import 'package:plants_app/features/home/domain/entities/home_entity.dart';
import 'package:plants_app/features/home/domain/use_cases/home_use_case.dart';
import 'package:plants_app/features/home/presentation/bloc/home_bloc.dart';
import 'routers.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/features/home/presentation/pages/home_feature_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeBloc(
            GetIt.I<HomeIdentifyPlantUseCase>(),
            GetIt.I<HomeGetPlantDetailsUseCase>(),
          ),

          child: const HomeFeatureScreen(),
        ),
      ),

      GoRoute(
        path: Routes.details,
        builder: (context, state) {
          final ex = state.extra as HomeEntity;
          return BlocProvider(
            create: (context) => GetIt.I<DetailsCubit>()..getDetailsMethod(ex.name),
            child: DetailsFeatureScreen(extra: ex),
          );
        },
      ),
    ],

    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
