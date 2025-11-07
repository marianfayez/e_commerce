import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/core/widgets/main_text_field.dart';
import 'package:e_commerce_app/core/widgets/validators.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_state.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/AddAddressSheet.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/AddressDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  bool isFullNameReadOnly = true;
  bool isEmailReadOnly = true;
  bool isPasswordReadOnly = true;
  bool isMobileNumberReadOnly = true;
  bool isAddressReadOnly = true;
  String selectedAddressText = "";
  final TextEditingController addressController = TextEditingController();

  // @override
  // void dispose() {
  //   addressController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()
        ..add(GetData())
        ..add(GetAddresses()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.addAddressRequestState == RequestState.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Address added successfully")),
            );
          }

          if (state.addAddressRequestState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ Failed: ${state.addAddressFailures}")),
            );
          }
          AppConstants.loadingDialog(
              context, state.getDataRequestState == RequestState.loading);
        },
        builder: (context, state) {
          if (state.addressModel?.data != null &&
              state.addressModel!.data!.isNotEmpty &&
              state.addressModel!.data!.any((address) => address.id != null)) {
            final validAddress = state.addressModel!.data!
                .firstWhere((address) => address.id != null,
                orElse: () => state.addressModel!.data!.first);

            addressController.text = selectedAddressText.isNotEmpty
                ? selectedAddressText
                : validAddress.details ?? '';
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SvgPicture.asset(
                    //   SvgAssets.routeLogo,
                    //   height: 40.h,
                    //   colorFilter: ColorFilter.mode(
                    //     ColorManager.primary,
                    //     BlendMode.srcIn,
                    //   ),
                    // ),
                    SizedBox(height: 20.h),
                    Text(
                      state.authModel?.user?.name ?? "",
                      style: getSemiBoldStyle(
                          color: ColorManager.primary, fontSize: FontSize.s18),
                    ),
                    Text(
                      state.authModel?.user?.email ?? "",
                      style: getRegularStyle(
                          color: ColorManager.primary.withOpacity(.5),
                          fontSize: FontSize.s14),
                    ),
                    SizedBox(height: 18.h),
                    BuildTextField(
                      borderBackgroundColor:
                          ColorManager.primary.withOpacity(.5),
                      readOnly: isFullNameReadOnly,
                      backgroundColor: ColorManager.white,
                      hint: 'Enter your full name',
                      label: 'Full Name',
                      controller: TextEditingController(
                          text: state.authModel?.user?.name ?? ""),
                      labelTextStyle: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s18),
                      // suffixIcon: IconButton(
                      //   icon: SvgPicture.asset(SvgAssets.edit),
                      //   onPressed: () {
                      //     setState(() {
                      //       isFullNameReadOnly = false;
                      //     });
                      //   },
                      // ),
                      textInputType: TextInputType.text,
                      validation: AppValidators.validateFullName,
                      hintTextStyle:
                          getRegularStyle(color: ColorManager.primary)
                              .copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 18.h),
                    BuildTextField(
                      borderBackgroundColor:
                          ColorManager.primary.withOpacity(.5),
                      readOnly: isEmailReadOnly,
                      backgroundColor: ColorManager.white,
                      hint: 'Enter your email address',
                      label: 'E-mail address',
                      controller: TextEditingController(
                          text: state.authModel?.user?.email ?? ""),
                      labelTextStyle: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s18),
                      // suffixIcon: IconButton(
                      //   icon: SvgPicture.asset(SvgAssets.edit),
                      //   onPressed: () {
                      //     setState(() {
                      //       isEmailReadOnly = false;
                      //     });
                      //   },
                      // ),
                      textInputType: TextInputType.emailAddress,
                      validation: AppValidators.validateEmail,
                      hintTextStyle:
                          getRegularStyle(color: ColorManager.primary)
                              .copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 18.h),
                    BuildTextField(
                      onTap: () {
                        setState(() {
                          isPasswordReadOnly = false;
                        });
                      },
                      controller:
                          TextEditingController(text: '123456789123456'),
                      borderBackgroundColor:
                          ColorManager.primary.withOpacity(.5),
                      readOnly: isPasswordReadOnly,
                      backgroundColor: ColorManager.white,
                      hint: 'Enter your password',
                      label: 'Password',
                      isObscured: true,
                      labelTextStyle: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s18),
                      // suffixIcon: SvgPicture.asset(SvgAssets.edit),
                      textInputType: TextInputType.text,
                      validation: AppValidators.validatePassword,
                      hintTextStyle:
                          getRegularStyle(color: ColorManager.primary)
                              .copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 18.h),
                    BuildTextField(
                      controller: TextEditingController(
                          text: state.authModel?.user?.phone ?? ""),
                      borderBackgroundColor:
                          ColorManager.primary.withOpacity(.5),
                      readOnly: isMobileNumberReadOnly,
                      backgroundColor: ColorManager.white,
                      hint: 'Enter your mobile no.',
                      label: 'Your mobile number',
                      labelTextStyle: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s18),
                      // suffixIcon: IconButton(
                      //   icon: SvgPicture.asset(SvgAssets.edit),
                      //   onPressed: () {
                      //     setState(() {
                      //       isMobileNumberReadOnly = false;
                      //     });
                      //   },
                      // ),
                      textInputType: TextInputType.phone,
                      validation: AppValidators.validatePhoneNumber,
                      hintTextStyle:
                          getRegularStyle(color: ColorManager.primary)
                              .copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 18.h),
                    if (state.addressModel?.data != null &&
                        state.addressModel!.data!.isNotEmpty &&
                        state.addressModel!.data!
                            .any((address) => address.id != null))
                      BuildTextField(
                        controller: addressController,
                        borderBackgroundColor:
                            ColorManager.primary.withOpacity(.5),
                        readOnly: isAddressReadOnly,
                        backgroundColor: ColorManager.white,
                        hint: 'Address',
                        label: 'Your Address',
                        labelTextStyle: getMediumStyle(
                            color: ColorManager.primary, fontSize: 18),
                        // suffixIcon: IconButton(
                        //   icon: SvgPicture.asset(SvgAssets.edit),
                        //   onPressed: () {
                        //     setState(() {
                        //       isAddressReadOnly = false;
                        //     });
                        //   },
                        // ),
                        textInputType: TextInputType.streetAddress,
                        validation: AppValidators.validateFullName,
                        hintTextStyle:
                            getRegularStyle(color: ColorManager.primary)
                                .copyWith(fontSize: 18.sp),
                      ),
                    SizedBox(height: 50.h),
                    CustomElevatedButton(
                      label: (state.addressModel?.data != null &&
                              state.addressModel!.data!.isNotEmpty &&
                              state.addressModel!.data!
                                  .any((address) => address.id != null))
                          ? 'Show All Shipping Addresses'
                          : 'Add Shipping Address',
                      onTap: () {
                        final validAddresses = state.addressModel?.data
                                ?.where((address) => address.id != null)
                                .toList() ??
                            [];
                        final blocContext = context;
                        if (validAddresses.isNotEmpty) {
                          showDialog(
                            context: blocContext,
                            builder: (_) => AddressDialog(
                              onSelectAddress: (selectedAddress) {
                                setState(() {
                                  selectedAddressText =
                                      selectedAddress.details ?? "";
                                  addressController.text = selectedAddressText;
                                });
                              },
                              profileBloc: blocContext.read<ProfileBloc>(),
                              addresses: validAddresses,
                              onSave: (String name, String details,
                                  String phone, String city) {
                                blocContext.read<ProfileBloc>().add(AddAddress(
                                    AddressData(
                                        name: name,
                                        details: details,
                                        phone: phone,
                                        city: city)));
                              },
                            ),
                          );
                        } else {
                          showModalBottomSheet(
                            context: blocContext,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: SingleChildScrollView(
                                  child: AddAddressSheet(
                                    onSave: (name, details, phone, city) {
                                      blocContext.read<ProfileBloc>().add(
                                          AddAddress(AddressData(
                                              name: name,
                                              details: details,
                                              phone: phone,
                                              city: city)));
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 25.h),
                    CustomElevatedButton(
                      label: 'Change Password',
                      onTap: () async {},
                    ),
                    SizedBox(height: 25.h),
                    CustomElevatedButton(
                      label: 'Log Out',
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        context.pushRoute(SignInRoute());
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
