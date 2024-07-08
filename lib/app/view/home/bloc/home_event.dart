part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class CartStarted extends HomeEvent {
  @override
  List<Object> get props => [];
}

