part of 'discover_cubit.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();
}

final class DiscoverInitialState extends DiscoverState {
  @override
  List<Object> get props => [];
}

final class DiscoverLoadingState extends DiscoverState {
  @override
  List<Object> get props => [];
}

final class DiscoverLoadedState extends DiscoverState {
  @override
  List<Object> get props => [];
}

final class DiscoverErrorState extends DiscoverState {
  final String message;

  const DiscoverErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class DiscoverEmptyState extends DiscoverState {
  final String message;

  const DiscoverEmptyState({required this.message});

  @override
  List<Object> get props => [];
}
