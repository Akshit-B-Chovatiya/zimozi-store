part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartInitialState extends CartState {
  @override
  List<Object> get props => [];
}

final class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

final class CartLoadedState extends CartState {
  @override
  List<Object> get props => [];
}

final class CartErrorState extends CartState {
  final String message;

  const CartErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class CartAPILoadingState extends CartState {
  @override
  List<Object> get props => [];
}

final class CartAPILoadedState extends CartState {
  @override
  List<Object> get props => [];
}

final class CartAPIErrorState extends CartState {
  final String message;

  const CartAPIErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class CartUpdatedState extends CartState {
  final String message;

  const CartUpdatedState({required this.message});

  @override
  List<Object> get props => [];
}

final class CartEmptyState extends CartState {
  final String message;

  const CartEmptyState({required this.message});

  @override
  List<Object> get props => [];
}
