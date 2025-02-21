part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

final class ForgotPasswordInitialState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgotPasswordLoadingState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgotPasswordLoadedState extends ForgotPasswordState {
  final String message;

  const ForgotPasswordLoadedState({required this.message});

  @override
  List<Object> get props => [];
}

final class ForgotPasswordErrorState extends ForgotPasswordState {
  final String message;

  const ForgotPasswordErrorState({required this.message});

  @override
  List<Object> get props => [];
}
