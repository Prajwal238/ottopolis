import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ottopolis/bloc/show_bloc.dart';
import 'package:ottopolis/bloc/show_event.dart';
import 'package:ottopolis/bloc/show_state.dart';
import 'package:ottopolis/cubit/internet_cubit.dart';
import 'package:ottopolis/model/show_model.dart';
import 'package:ottopolis/repo/show_repo.dart';

class MockShowRepo extends Mock implements ShowRepo{}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('FetchShows', () {
    late MockShowRepo mockShowRepo;
    late ShowBloc showBloc;
    List<ShowModel>? show = [ShowModel(score: 0.12, show: Show())];

    setUp(() {
      mockShowRepo = MockShowRepo();
      showBloc = ShowBloc(mockShowRepo, internetCubit: InternetCubit(connectivity: Connectivity()));
    });

    blocTest('emits [ShowIsLoading,ShowIsLoaded when successful]',
    build: () {
      when(()  => mockShowRepo.getShowsList('manifest')).thenAnswer((_) async => show);
      return ShowBloc(mockShowRepo, internetCubit: InternetCubit(connectivity: Connectivity()));
    },
    act:(bloc) => bloc.add(FetchShows('manifest')),
    expect: () => [
      ShowIsLoading(),
      ShowIsLoaded(show)
    ]
    );

    tearDown(() {
      showBloc.close();
    });
  });
}