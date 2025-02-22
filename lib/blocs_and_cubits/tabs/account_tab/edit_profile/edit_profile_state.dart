part of 'edit_profile_cubit.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();
}

final class EditProfileInitialState extends EditProfileState {
  @override
  List<Object> get props => [];
}

final class EditProfileLoadingState extends EditProfileState {
  @override
  List<Object> get props => [];
}

final class EditProfileLoadedState extends EditProfileState {
  final String message;

  const EditProfileLoadedState({required this.message});

  @override
  List<Object> get props => [];
}

final class EditProfileErrorState extends EditProfileState {
  final String message;

  const EditProfileErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class EditProfileUpdatedState extends EditProfileState {
  @override
  List<Object> get props => [];
}

