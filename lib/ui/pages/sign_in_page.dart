// import 'package:bank_sha/blocs/auth/auth_bloc.dart';
// import 'package:bank_sha/models/sign_in_form_model.dart';
// import 'package:bank_sha/shared/shared_methods.dart';
// import 'package:bank_sha/shared/theme.dart';
// import 'package:bank_sha/ui/widgets/buttons.dart';
// import 'package:bank_sha/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raion_battlepass/blocs/bloc/auth_bloc.dart';
import 'package:raion_battlepass/models/sign_in_form_model.dart';
import 'package:raion_battlepass/shared/shared_method.dart';
import 'package:raion_battlepass/shared/theme.dart';
import 'package:raion_battlepass/ui/widget/buttons.dart';
import 'package:raion_battlepass/ui/widget/custom_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final nimController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nimController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          } else if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Container(
                height: 50,
                width: 155,
                margin: const EdgeInsets.only(top: 100, bottom: 100),
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage(
                //       "assets/img_logo_light.png",
                //     ),
                //   ),
                // ),
              ),
              Text(
                "Sign In &\nGrow Your Finance",
                style:
                    blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  // color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Note EMAIL INPUT
                    CustomFormField(
                      title: "Email Address",
                      controller: nimController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Note PASSWORD INPUT
                    CustomFormField(
                      title: "Password",
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password",
                        style: blueTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: "Sign In",
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  SignInFormModel(
                                      nim: nimController.text,
                                      password: passwordController.text),
                                ),
                              );
                        } else {
                          showCustomSnackbar(
                              context, "Semau field harus diisi");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomTextButton(
                      title: "Create New Account",
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign-up');
                      },
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
