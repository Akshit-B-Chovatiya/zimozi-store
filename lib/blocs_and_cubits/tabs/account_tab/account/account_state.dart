part of 'account_cubit.dart';

sealed class AccountState extends Equatable {
  const AccountState();
}

final class AccountInitialState extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountLoadingState extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountLoadedState extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountErrorState extends AccountState {
  final String message;

  const AccountErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class AccountAPILoadingState extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountAPILoadedState extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountAPIErrorState extends AccountState {
  final String message;

  const AccountAPIErrorState({required this.message});

  @override
  List<Object> get props => [];
}
