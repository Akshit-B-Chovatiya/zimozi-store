import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/checkout_process/address_details/address_details_cubit.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/text_field_view.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key, required this.onSave, required this.isForEdit, this.address});

  final Function(AddressModel address) onSave;
  final bool isForEdit;
  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(
              title: "${isForEdit ? "Edit" : "Add"} Address",
              prefixIcon: AppImages.backArrowIcon,
              onPrefixPressed: () {
                PageNavigator.pop(context: context);
              }),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: BlocProvider(
              create: (context) => AddressDetailsCubit()..setPreSelectedData(address: address),
              child: BlocConsumer<AddressDetailsCubit, AddressDetailsState>(
                listener: (context, state) {
                  if (state is AddressDetailsLoadingState) {
                    showLoadingDialog(context: context);
                  } else if (state is AddressDetailsLoadedState) {
                    hideLoadingDialog(context: context);
                    showToastMessage(context: context, message: state.message);
                    PageNavigator.pop(context: context);
                  } else if (state is AddressDetailsErrorState) {
                    hideLoadingDialog(context: context);
                    showToastMessage(context: context, message: state.message, isErrorMessage: true);
                  }
                },
                builder: (context, state) {
                  AddressDetailsCubit cubit = BlocProvider.of<AddressDetailsCubit>(context);
                  return Column(
                    children: [
                      TextFieldView(
                          controller: cubit.houseNumberController,
                          label: "House number",
                          hint: "Enter house number"),
                      TextFieldView(
                          controller: cubit.streetNameController,
                          label: "Street name",
                          hint: "Enter street name"),
                      TextFieldView(
                          controller: cubit.cityNameController, label: "City", hint: "Enter city name"),
                      TextFieldView(
                          controller: cubit.stateNameController, label: "State", hint: "Enter state name"),
                      TextFieldView(
                          controller: cubit.pinCodeNumberController,
                          label: "Pin-Code",
                          hint: "Enter pin code"),
                      TextFieldView(
                          controller: cubit.countryNameController,
                          label: "Country",
                          hint: "Enter country name"),
                      ButtonView(
                          title: "Save",
                          onTap: () {
                            cubit.validateAndSaveAddress(isForEdit: isForEdit, onSave: onSave);
                          })
                    ],
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
