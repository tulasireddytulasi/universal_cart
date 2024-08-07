part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class CartLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class CartLoaded extends HomeState {
  const CartLoaded({
    required this.products,
    required this.totalPrice,
    required this.totalDiscount,
    required this.quantity,
  });

  final List<CartItemModel> products;
  final double totalPrice;
  final double totalDiscount;
  final int quantity;

  @override
  List<Object> get props => [products, totalPrice, totalDiscount];
}

final class CartError extends HomeState {
  @override
  List<Object> get props => [];
}