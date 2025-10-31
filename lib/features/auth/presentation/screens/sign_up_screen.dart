import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/core/widgets/main_text_field.dart';
import 'package:e_commerce_app/core/widgets/validators.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds_impl.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:e_commerce_app/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_cases/sign_up_use_cases.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var mobileController = TextEditingController();
  var rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.requestState == RequestState.loading) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Center(child: CircularProgressIndicator()),
                      backgroundColor: Colors.transparent,
                    ));
          } else if (state.requestState == RequestState.error) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(state.routeFailures?.message ??
                          "Something went wrong"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"))
                      ],
                    ));
          } else if (state.requestState == RequestState.success) {
            context.router.replaceAll([const MainRoute()]);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(child: SvgPicture.asset(Assets.svgImages.route)),
                      SizedBox(
                        height: 40.h,
                      ),
                      BuildTextField(
                        backgroundColor: ColorManager.white,
                        hint: 'enter your full name',
                        label: 'Full Name',
                        controller: nameController,
                        textInputType: TextInputType.name,
                        validation: AppValidators.validateFullName,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      BuildTextField(
                        hint: 'enter your email address',
                        backgroundColor: ColorManager.white,
                        label: 'E-mail address',
                        controller: emailController,
                        validation: AppValidators.validateEmail,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      BuildTextField(
                        hint: 'enter your password',
                        backgroundColor: ColorManager.white,
                        label: 'password',
                        controller: passwordController,
                        validation: AppValidators.validatePassword,
                        isObscured: true,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      BuildTextField(
                        hint: 'confirm your password',
                        backgroundColor: ColorManager.white,
                        label: 'Confirm Password',
                        controller: rePasswordController,
                        validation: (val) =>
                            AppValidators.validateConfirmPassword(
                                val, passwordController.text),
                        isObscured: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      BuildTextField(
                        hint: 'enter your mobile number',
                        backgroundColor: ColorManager.white,
                        label: 'Mobile Number',
                        controller: mobileController,
                        validation: AppValidators.validatePhoneNumber,
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: SizedBox(
                          height: 60.h,
                          width: MediaQuery.of(context).size.width * .9,
                          child: CustomElevatedButton(
                            // borderRadius: AppSize.s8,
                            label: 'Sign Up',
                            isStadiumBorder: false,
                            backgroundColor: ColorManager.white,
                            textStyle: getBoldStyle(
                                color: ColorManager.primary, fontSize: 20),
                            onTap: () {
                              SignUpRequestModel model = SignUpRequestModel(
                                  name: nameController.text,
                                  phone: mobileController.text,
                                  password: passwordController.text,
                                  rePassword: rePasswordController.text,
                                  email: emailController.text);
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignUpEvent(model));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
