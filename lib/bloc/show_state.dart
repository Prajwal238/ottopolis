import 'package:equatable/equatable.dart';
import '../model/show_model.dart';

class ShowState extends Equatable {
  @override

  List<Object?> get props => [];

}

class ShowIsNotSearched extends ShowState {

}

class InternetConnectionLost extends ShowState {

}

class ShowIsLoading extends ShowState {
  
}

class ShowIsLoaded extends ShowState {
  final List<ShowModel>? _showDetails;

  ShowIsLoaded(this._showDetails);
  List<ShowModel>? get getShowDetails => _showDetails;

  @override

  List<Object?> get props => [_showDetails];
}

class ShowIsNotLoaded extends ShowState {
  
}
