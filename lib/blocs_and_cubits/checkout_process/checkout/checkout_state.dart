part of 'checkout_cubit.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();
}

final class CheckoutInitialState extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutLoadingState extends CheckoutState {
  @override
  List<Object> get props => [];
}

final class CheckoutLoadedState extends CheckoutState {
  final String message;

  const CheckoutLoadedState({required this.message});

  @override
  List<Object> get props => [];
}

final class CheckoutErrorState extends CheckoutState {
  final String message;

  const CheckoutErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class CheckoutUpdatedState extends CheckoutState {
  @override
  List<Object> get props => [];
}
