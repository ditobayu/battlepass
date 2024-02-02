// import 'package:bank_sha/blocs/auth/auth_bloc.dart';
// import 'package:bank_sha/blocs/user/user_bloc.dart';
// import 'package:bank_sha/shared/theme.dart';
// import 'package:bank_sha/ui/pages/data_provider_page.dart';
// import 'package:bank_sha/ui/pages/data_success_page.dart';
// import 'package:bank_sha/ui/pages/home_page.dart';
// import 'package:bank_sha/ui/pages/onboarding_page.dart';
// import 'package:bank_sha/ui/pages/pin_page.dart';
// import 'package:bank_sha/ui/pages/profile_edit_page.dart';
// import 'package:bank_sha/ui/pages/profile_edit_pin_page.dart';
// import 'package:bank_sha/ui/pages/profile_edit_success_page.dart';
// import 'package:bank_sha/ui/pages/profile_page.dart';
// import 'package:bank_sha/ui/pages/sign_in_page.dart';
// import 'package:bank_sha/ui/pages/sign_up_page.dart';
// import 'package:bank_sha/ui/pages/sign_up_success_page.dart';
// import 'package:bank_sha/ui/pages/splash_page.dart';
// import 'package:bank_sha/ui/pages/topup_page.dart';
// import 'package:bank_sha/ui/pages/topup_success.dart';
// import 'package:bank_sha/ui/pages/transfer_page.dart';
// import 'package:bank_sha/ui/pages/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raion_battlepass/blocs/bloc/auth_bloc.dart';
import 'package:raion_battlepass/shared/theme.dart';
import 'package:raion_battlepass/ui/pages/sign_in_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // cek apakah ada user yang tersimpan di local
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        // BlocProvider(
        //   create: (context) => UserBloc(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          // '/': (context) => const SplashPage(),
          // '/onboarding': (context) => const OnboardingPage(),
          // '/sign-in': (context) => const SignInPage(),
          '/': (context) => const SignInPage(),
          // '/sign-up': (context) => const SignUpPage(),
          // '/sign-up-success': (context) => const SignUpSuccesPage(),
          // '/home': (context) => const HomePage(),
          // '/profile': (context) => const ProfilePage(),
          // '/pin': (context) => const PinPage(),
          // '/profile-edit': (context) => const ProfileEditPage(),
          // '/profile-edit-pin': (context) => const ProfileEditPinPage(),
          // '/profile-edit-success': (context) => const ProfileEditSuccessPage(),
          // '/topup': (context) => const TopupPage(),
          // '/topup-success': (context) => const TopupSuccessPage(),
          // '/transfer': (context) => const TransferPage(),
          // '/transfer-success': (context) => const TransferSuccessPage(),
          // '/data-provider': (context) => const DataProviderPage(),
          // '/data-success': (context) => const DataSuccessPage(),
        },
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: lightBackgroundColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: blackColor,
            ),
            titleTextStyle: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          scaffoldBackgroundColor: lightBackgroundColor,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
        ),
      ),
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(2.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}
