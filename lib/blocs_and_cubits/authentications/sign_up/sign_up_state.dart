part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
}

final class SignUpInitialState extends SignUpState {
  @override
  List<Object> get props => [];
}

final class SignUpLoadingState extends SignUpState {
  @override
  List<Object> get props => [];
}

final class SignUpLoadedState extends SignUpState {
  final String message;

  const SignUpLoadedState({required this.message});

  @override
  List<Object> get props => [];
}

final class SignUpErrorState extends SignUpState {
  final String message;

  const SignUpErrorState({required this.message});

  @override
  List<Object> get props => [];
}
