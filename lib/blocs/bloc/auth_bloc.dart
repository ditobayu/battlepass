import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raion_battlepass/models/sign_in_form_model.dart';
import 'package:raion_battlepass/models/sign_up_form_model.dart';
import 'package:raion_battlepass/models/update_user_form_model.dart';
import 'package:raion_battlepass/models/user_model.dart';
import 'package:raion_battlepass/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());

          final user = await AuthService().register(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final user = await AuthService().login(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final SignInFormModel data =
              await AuthService().getCredentialFromLocal();

          final UserModel user = await AuthService().login(data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // if (event is AuthUpdateUser) {
      //   try {
      //     if (state is AuthSuccess) {
      //       final updatedUser = (state as AuthSuccess).user.copyWith(
      //             username: event.data.username,
      //             name: event.data.name,
      //             email: event.data.email,
      //             password: event.data.password,
      //           );

      //       emit(AuthLoading());

      //       await AuthService().updateUser(event.data);

      //       emit(AuthSuccess(updatedUser));
      //     }
      //   } catch (e) {
      //     emit(AuthFailed(e.toString()));
      //   }
      // }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());

          await AuthService().logout();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
