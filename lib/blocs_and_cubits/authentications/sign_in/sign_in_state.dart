part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

final class SignInInitialState extends SignInState {
  @override
  List<Object> get props => [];
}

final class SignInLoadingState extends SignInState {
  @override
  List<Object> get props => [];
}

final class SignInLoadedState extends SignInState {
  final String message;

  const SignInLoadedState({required this.message});

  @override
  List<Object> get props => [];
}

final class SignInErrorState extends SignInState {
  final String message;

  const SignInErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class SignInUpdatedState extends SignInState {
  @override
  List<Object> get props => [];
}
