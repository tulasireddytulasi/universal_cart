part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class CartStarted extends HomeEvent {
  @override
  List<Object> get props => [];
}

final class CartItemAdded extends HomeEvent {
  const CartItemAdded({required this.item});

  final Product item;

  @override
  List<Object> get props => [item];
}

final class CartItemRemoved extends HomeEvent {
  const CartItemRemoved(this.item);

  final Product item;

  @override
  List<Object> get props => [item];
}

