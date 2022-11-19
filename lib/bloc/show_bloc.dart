import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ottopolis/bloc/show_event.dart';
import 'package:ottopolis/bloc/show_state.dart';
import 'package:ottopolis/cubit/internet_cubit.dart';

import '../model/show_model.dart';
import '../repo/show_repo.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  final InternetCubit internetCubit;
  StreamSubscription? internetStreamSubscription;

  ShowRepo showRepo;
  ShowBloc(this.showRepo, {required this.internetCubit}) : super(ShowIsNotSearched()) {
    listenToInternetCubit();
    log("Inside inside bloc");
    on<ConnectionLost>((event, emit) {
      _connectionLost(emit);
    });
    on<FetchShows>((event, emit) async {
      log("Inside inside fetch");
      await _fetchShows(emit, event.getShowName);
    });
    on<ResetShows>(
      (event, emit) => _resetShows(emit),
    );
  }

  Future<void> _fetchShows(Emitter<ShowState> emit, String showName) async {
    log("Inside FetchShows Event inside bloc");
    emit(ShowIsLoading());
    try {
      List<ShowModel>? shows = await showRepo.getShowsList(showName);
      log("hereeeeeeee $shows");
      emit(ShowIsLoaded(shows));
    } catch (err) {
      //TODO:Implement Error Handeling
      print(err);
      emit(ShowIsNotLoaded());
    }
  }

  void _resetShows(Emitter<ShowState> emit) {
    emit(ShowIsNotSearched());
  }

  void _connectionLost(Emitter<ShowState> emit) {
    emit(InternetConnectionLost());
  }

  void listenToInternetCubit() {
    internetStreamSubscription ??= internetCubit.stream.listen((state) {
      inspect(state);
      if (state is InternetDisconnected) {
        add(ConnectionLost());
      } else {
        add(ResetShows());
      }
    });
  }

  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}
