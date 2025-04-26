part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}


class OnTabSwitch extends HomeEvent {
  final Tabs tabs;
  final bool isNew;
  const OnTabSwitch({required this.tabs,required this.isNew});

  @override
  List<Object?> get props => [];
}
class SwitchList extends HomeEvent {
  const SwitchList();

  @override
  List<Object?> get props => [];
}
class OnSearchMovie extends HomeEvent {
  final String movie;
  const OnSearchMovie({required this.movie});

  @override
  List<Object?> get props => [];
}

class FetchGenre extends HomeEvent {
  const FetchGenre();

  @override
  List<Object?> get props => [];
}

class GenreTap extends HomeEvent {
  final int index;
  const GenreTap({required this.index});

  @override
  List<Object?> get props => [];
}

class ApplyFilter extends HomeEvent {
  const ApplyFilter();

  @override
  List<Object?> get props => [];
}

class ClearFilter extends HomeEvent {
  const ClearFilter();

  @override
  List<Object?> get props => [];
}

class Reset extends HomeEvent {
  const Reset();

  @override
  List<Object?> get props => [];
}