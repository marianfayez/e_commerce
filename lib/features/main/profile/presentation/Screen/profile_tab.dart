import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/core/widgets/main_text_field.dart';
import 'package:e_commerce_app/core/widgets/validators.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_state.dart';
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
  bool showAddForm = false;
  bool isFullNameReadOnly = true;
  bool isEmailReadOnly = true;
  bool isPasswordReadOnly = true;
  bool isMobileNumberReadOnly = true;
  bool isAddressReadOnly = true;
  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController addressDetailsController =
      TextEditingController();
  final TextEditingController addressPhoneController = TextEditingController();
  final TextEditingController addressCityController = TextEditingController();
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
            context
                .read<ProfileBloc>()
                .add(GetAddresses()); // نحدث القائمة بعد الإضافة
            setState(() => showAddForm = false);
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
                        state.addressModel!.data!.isNotEmpty)
                      BuildTextField(
                        controller: TextEditingController(
                            text:
                                state.addressModel!.data!.first.details ?? ''),
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
                      label: 'Add Shipping Address',
                      onTap: () => showAddAddressSheet(context),
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
void showAddAddressSheet(BuildContext context) {
  final nameController = TextEditingController();
  final detailsController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add New Address",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: "Details"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: "City"),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async{
                    final name = nameController.text.trim();
                    final details = detailsController.text.trim();
                    final phone = phoneController.text.trim();
                    final city = cityController.text.trim();

                    if ([name, details, phone, city].any((e) => e.isEmpty)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("❌ Please fill all fields")),
                      );
                      return;
                    }

                    // ✅ Add address via BLoC or repository
                    context.read<ProfileBloc>().add(AddAddress(name, details, phone, city));

                    Navigator.pop(sheetContext);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}