part of 'my_orders_tab_cubit.dart';

sealed class MyOrdersTabState extends Equatable {
  const MyOrdersTabState();
}

final class MyOrdersTabInitialState extends MyOrdersTabState {
  @override
  List<Object> get props => [];
}

final class MyOrdersTabLoadingState extends MyOrdersTabState {
  @override
  List<Object> get props => [];
}

final class MyOrdersTabLoadedState extends MyOrdersTabState {
  @override
  List<Object> get props => [];
}

final class MyOrdersTabErrorState extends MyOrdersTabState {
  final String message;

  const MyOrdersTabErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class MyOrdersTabEmptyState extends MyOrdersTabState {
  final String message;

  const MyOrdersTabEmptyState({required this.message});

  @override
  List<Object> get props => [];
}
