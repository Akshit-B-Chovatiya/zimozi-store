import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';

part 'address_details_state.dart';

class AddressDetailsCubit extends Cubit<AddressDetailsState> {
  AddressDetailsCubit() : super(AddressDetailsInitialState());

  final TextEditingController houseNumberController = TextEditingController(text: "154");
  final TextEditingController streetNameController = TextEditingController(text: "Abhsishek Arcade");
  final TextEditingController cityNameController = TextEditingController(text: "Surat");
  final TextEditingController stateNameController = TextEditingController(text: "Gujarat");
  final TextEditingController pinCodeNumberController = TextEditingController(text: "395006");
  final TextEditingController countryNameController = TextEditingController(text: "India");

  void setPreSelectedData({AddressModel? address}) {
    if (address != null) {
      emit(AddressDetailsInitialState());
      houseNumberController.text = address.houseNumber;
      streetNameController.text = address.street;
      cityNameController.text = address.city;
      stateNameController.text = address.state;
      pinCodeNumberController.text = address.pinCode;
      countryNameController.text = address.country;
      emit(AddressDetailsUpdatedState());
    }
  }

  void validateAndSaveAddress({required Function(AddressModel address) onSave, required bool isForEdit}) {
    emit(AddressDetailsLoadingState());
    if (houseNumberController.text.trim().isEmpty) {
      emit(AddressDetailsErrorState(message: "Please enter house number!"));
    } else if (streetNameController.text.trim().isEmpty) {
      emit(AddressDetailsErrorState(message: "Please enter street name!"));
    } else if (cityNameController.text.trim().isEmpty) {
      emit(AddressDetailsErrorState(message: "Please enter city name!"));
    } else if (stateNameController.text.trim().isEmpty) {
      emit(AddressDetailsErrorState(message: "Please enter state name!"));
    } else if (pinCodeNumberController.text.trim().isEmpty) {
      emit(AddressDetailsErrorState(message: "Please enter pin code!"));
    } else if (countryNameController.text.trim().isEmpty) {
      emit(AddressDetailsErrorState(message: "Please enter country name!"));
    } else {
      onSave(AddressModel(
          houseNumber: houseNumberController.text.trim(),
          street: streetNameController.text.trim(),
          city: cityNameController.text.trim(),
          state: stateNameController.text.trim(),
          pinCode: pinCodeNumberController.text.trim(),
          country: countryNameController.text.trim()));
      emit(AddressDetailsLoadedState(message: isForEdit ? "Address updated!" : "Address saved!"));
    }
  }
}
