import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/changePassword.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_state.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/AddressDialog.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/ProfileInfoSection.dart';
import 'package:e_commerce_app/features/main/profile/presentation/widgets/customFormSheet.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()
        ..add(GetData())
        ..add(GetAddresses()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) async {
          if (state.isLoggedOut ==true) {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Session expired. Please login again.")),
            );

            context.router.replaceAll([SignInRoute()]);
            return;
          }
          AppConstants.loadingDialog(
              context,
              state.getDataRequestState == RequestState.loading ||
                  state.addAddressRequestState == RequestState.loading ||
                  state.updateProfileRequestState == RequestState.loading);

          if (state.addAddressRequestState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ Failed: ${state.addAddressFailures}")),
            );
          }
          if (state.updateProfileRequestState == RequestState.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Profile updated successfully")),
            );
          }

          if (state.updateProfileRequestState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("❌ Update failed: ${state.updateProfileFailures}")),
            );
          }
        },
        builder: (context, state) {
          phoneController.text = state.authModel?.user?.phone ?? "";
          nameController.text = state.authModel?.user?.name ?? "";
          emailController.text = state.authModel?.user?.email ?? "";
          if (state.addressModel?.data != null &&
              state.addressModel!.data!.isNotEmpty &&
              state.addressModel!.data!.any((address) => address.id != null)) {
            final validAddress = state.addressModel!.data!.firstWhere(
                (address) => address.id != null,
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
                    ProfileInfoSection(
                      label: 'Full Name',
                      value: nameController.text,
                      controller: nameController,
                      isEditing: !isFullNameReadOnly,
                      icon: Icons.person,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 18.h),
                    ProfileInfoSection(
                      label: 'Email',
                      value: emailController.text,
                      controller: emailController,
                      isEditing: !isEmailReadOnly,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                    ),
                    // SizedBox(height: 18.h),
                    // BuildTextField(
                    //   onTap: () {
                    //     setState(() {
                    //       isPasswordReadOnly = false;
                    //     });
                    //   },
                    //   controller:
                    //       TextEditingController(text: '123456789123456'),
                    //   borderBackgroundColor:
                    //       ColorManager.primary.withOpacity(.5),
                    //   readOnly: isPasswordReadOnly,
                    //   backgroundColor: ColorManager.white,
                    //   hint: 'Enter your password',
                    //   label: 'Password',
                    //   isObscured: true,
                    //   labelTextStyle: getMediumStyle(
                    //       color: ColorManager.primary, fontSize: FontSize.s18),
                    //   // suffixIcon: SvgPicture.asset(SvgAssets.edit),
                    //   textInputType: TextInputType.text,
                    //   validation: AppValidators.validatePassword,
                    //   hintTextStyle:
                    //       getRegularStyle(color: ColorManager.primary)
                    //           .copyWith(fontSize: 18.sp),
                    // ),
                    SizedBox(height: 18.h),
                    ProfileInfoSection(
                      label: 'Mobile Number',
                      value: phoneController.text,
                      controller: phoneController,
                      isEditing: !isMobileNumberReadOnly,
                      icon: Icons.phone,
                      inputType: TextInputType.phone,
                    ),
                    SizedBox(height: 18.h),
                    if (state.addressModel?.data != null &&
                        state.addressModel!.data!.isNotEmpty &&
                        state.addressModel!.data!
                            .any((address) => address.id != null))
                      ProfileInfoSection(
                        label: 'Address',
                        value: addressController.text,
                        controller: addressController,
                        isEditing: !isAddressReadOnly,
                        icon: Icons.location_on,
                        inputType: TextInputType.streetAddress,
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
                            builder: (_) => SingleChildScrollView(
                              child: CustomFormSheet(
                                title: "Add Address",
                                fields: [
                                  FormFieldData(
                                      key: "name",
                                      label: "Home/Work/..",
                                      controller: TextEditingController()),
                                  FormFieldData(
                                      key: "details",
                                      label: "Street Name",
                                      controller: TextEditingController()),
                                  FormFieldData(
                                      key: "phone",
                                      label: "Phone",
                                      controller: TextEditingController(),
                                      inputType: TextInputType.phone),
                                  FormFieldData(
                                      key: "city",
                                      label: "City",
                                      controller: TextEditingController()),
                                ],
                                onSave: (values) {
                                  blocContext
                                      .read<ProfileBloc>()
                                      .add(AddAddress(
                                        AddressData(
                                          name: values["name"]!,
                                          details: values["details"]!,
                                          phone: values["phone"]!,
                                          city: values["city"]!,
                                        ),
                                      ));
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            label: isFullNameReadOnly
                                ? 'Update Profile'
                                : 'Cancel',
                            onTap: () {
                              setState(() {
                                final editing = isFullNameReadOnly;
                                isFullNameReadOnly = !editing;
                                isEmailReadOnly = !editing;
                                isMobileNumberReadOnly = !editing;
                                isAddressReadOnly = !editing;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        if (!isFullNameReadOnly)
                          CustomElevatedButton(
                            label: 'Save Changes',
                            onTap: () {
                              final currentUser = state.authModel?.user;

                              final String? updatedName =
                                  nameController.text.trim().isNotEmpty &&
                                          nameController.text.trim() !=
                                              currentUser?.name
                                      ? nameController.text.trim()
                                      : null;

                              final String? updatedEmail =
                                  emailController.text.trim().isNotEmpty &&
                                          emailController.text.trim() !=
                                              currentUser?.email
                                      ? emailController.text.trim()
                                      : null;

                              final String? updatedPhone =
                                  phoneController.text.trim().isNotEmpty &&
                                          phoneController.text.trim() !=
                                              currentUser?.phone
                                      ? phoneController.text.trim()
                                      : null;

                              if (updatedName == null &&
                                  updatedEmail == null &&
                                  updatedPhone == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("No changes")),
                                );
                                return;
                              }
                              context
                                  .read<ProfileBloc>()
                                  .add(UpdateUserProfileEvent(
                                    name: nameController.text.isNotEmpty
                                        ? nameController.text
                                        : null,
                                    email: emailController.text.isNotEmpty
                                        ? emailController.text
                                        : null,
                                    phone: phoneController.text.isNotEmpty
                                        ? phoneController.text
                                        : null,
                                  ));
                              setState(() {
                                isFullNameReadOnly = true;
                                isEmailReadOnly = true;
                                isMobileNumberReadOnly = true;
                              });
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    CustomElevatedButton(
                      label: 'Change Password',
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => SingleChildScrollView(
                            child: CustomFormSheet(
                              title: "Change Password",
                              fields: [
                                FormFieldData(
                                  key: "currentPassword",
                                  label: "Current Password",
                                  controller: currentPasswordController,
                                  isPassword: true,
                                ),
                                FormFieldData(
                                  key: "password",
                                  label: "New Password",
                                  controller: passwordController,
                                  isPassword: true,
                                ),
                                FormFieldData(
                                  key: "rePassword",
                                  label: "Confirm Password",
                                  controller: rePasswordController,
                                  isPassword: true,
                                  validator: (value) {
                                    if (value != passwordController.text ) {
                                      return "Passwords do not match!";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                              onSave: (values) async {
                                context.read<ProfileBloc>().add(
                                      ChangePasswordEvent(
                                          model: ChangePasswordModel(
                                            currentPassword: currentPasswordController.text,
                                            password: passwordController.text,
                                            rePassword: rePasswordController.text,
                                      )),
                                    );
                              },
                            ),
                          ),
                        );
                      },
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
