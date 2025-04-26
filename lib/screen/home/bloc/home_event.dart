part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}


class OnTabSwitch extends HomeEvent {
  final Tabs tabs;
  const OnTabSwitch({required this.tabs});

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