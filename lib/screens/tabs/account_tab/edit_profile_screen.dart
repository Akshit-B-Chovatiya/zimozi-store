import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/edit_profile/edit_profile_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_field_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.onSuccessUpdate, required this.userDetails});

  final Function(bool) onSuccessUpdate;
  final ZimoziUser userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarView(
            title: "Edit Profile",
            prefixIcon: AppImages.backArrowIcon,
            onPrefixPressed: () {
              PageNavigator.pop(context: context);
            }),
        Expanded(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: BlocProvider(
            create: (context) => EditProfileCubit()..setPrefillData(userDetails: userDetails),
            child: BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileLoadingState) {
                  showLoadingDialog(context: context);
                } else if (state is EditProfileLoadedState) {
                  hideLoadingDialog(context: context);
                  showToastMessage(context: context, message: state.message);
                  onSuccessUpdate(true);
                  PageNavigator.pop(context: context);
                } else if (state is EditProfileErrorState) {
                  hideLoadingDialog(context: context);
                  showToastMessage(context: context, message: state.message, isErrorMessage: true);
                }
              },
              builder: (context, state) {
                EditProfileCubit cubit = BlocProvider.of<EditProfileCubit>(context);
                return Column(children: [
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, border: Border.all(color: AppColors.orangeColor)),
                      height: MediaQuery.of(context).size.width / 4,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.orangeColor)),
                        child: Container(
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
                            child: cubit.selectedProfileImage != null &&
                                    cubit.selectedProfileImage?.path != null &&
                                    cubit.selectedProfileImage!.path.isNotEmpty
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(MediaQuery.of(context).size.width / 2),
                                    child: ImageView(
                                        imageUrl: cubit.selectedProfileImage?.path ?? "",
                                        isAsset: true,
                                        boxFit: BoxFit.cover,
                                        isFile: true),
                                  )
                                : cubit.networkProfileImage != null && cubit.networkProfileImage!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(MediaQuery.of(context).size.width / 2),
                                        child: ImageView(
                                            imageUrl: cubit.selectedProfileImage != null &&
                                                    cubit.selectedProfileImage?.path != null &&
                                                    cubit.selectedProfileImage!.path.isNotEmpty
                                                ? (cubit.selectedProfileImage?.path ?? "")
                                                : (cubit.networkProfileImage ?? ""),
                                            boxFit: BoxFit.cover,
                                            isAsset: false),
                                      )
                                    : Center(
                                        child: SemiBoldTextView(
                                            data:
                                                "${cubit.firstNameController.text.isEmpty ? "" : cubit.firstNameController.text[0]}${cubit.lastNameController.text.isEmpty ? "" : cubit.lastNameController.text[0]}",
                                            textColor: AppColors.orangeColor,
                                            fontSize: 30))),
                      )),
                  TextFieldView(
                      controller: cubit.firstNameController,
                      label: "First Name",
                      hint: "Enter your first name"),
                  TextFieldView(
                      controller: cubit.lastNameController, label: "Last Name", hint: "Enter your last name"),
                  TextFieldView(
                      controller: cubit.emailController,
                      label: "Email",
                      hint: "Enter your email address",
                      isReadOnly: true),
                  TextFieldView(
                      controller: cubit.phoneNumberController,
                      label: "Phone",
                      hint: "Enter your phone number",
                      textInputType: TextInputType.number,
                      inputFormatters: allowOnlyNumbers),
                  ButtonView(
                      title: "Save",
                      bottomMargin: 30,
                      onTap: () async {
                        await cubit.validateAndUpdateDetails(context: context);
                      })
                ]);
              },
            ),
          ),
        )),
      ],
    ));
  }
}
