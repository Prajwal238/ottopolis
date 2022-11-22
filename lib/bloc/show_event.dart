import 'package:equatable/equatable.dart';

class ShowEvent extends Equatable {
  @override
  
  List<Object?> get props => throw UnimplementedError();
}

class FetchShows extends ShowEvent {
  final String _showName;
  String get getShowName => _showName;
  FetchShows(this._showName);

  @override
  
  List<Object?> get props => [_showName];
  
}

class ResetShows extends ShowEvent {
  
}

class ConnectionLost extends ShowEvent {
  
}
