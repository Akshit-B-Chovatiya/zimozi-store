part of 'address_details_cubit.dart';

sealed class AddressDetailsState extends Equatable {
  const AddressDetailsState();
}

final class AddressDetailsInitialState extends AddressDetailsState {
  @override
  List<Object> get props => [];
}

final class AddressDetailsLoadingState extends AddressDetailsState {
  @override
  List<Object> get props => [];
}

final class AddressDetailsLoadedState extends AddressDetailsState {
  final String message;

  const AddressDetailsLoadedState({required this.message});

  @override
  List<Object> get props => [];
}

final class AddressDetailsErrorState extends AddressDetailsState {
  final String message;

  const AddressDetailsErrorState({required this.message});

  @override
  List<Object> get props => [];
}

final class AddressDetailsUpdatedState extends AddressDetailsState {
  @override
  List<Object> get props => [];
}
