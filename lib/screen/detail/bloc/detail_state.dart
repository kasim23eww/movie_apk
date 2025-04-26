part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();
}

final class DetailInitial extends DetailState {
  @override
  List<Object> get props => [];
}
