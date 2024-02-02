import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raion_battlepass/models/sign_in_form_model.dart';
import 'package:raion_battlepass/models/sign_up_form_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler
    });
  }
}
