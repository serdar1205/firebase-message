import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/core/utils/usecase/usecase.dart';
import 'package:firebase_message/features/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import 'package:firebase_message/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:firebase_message/features/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:firebase_message/features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';
import 'package:firebase_message/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_message/core/utils/local/token_store.dart';
part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUseCase _currentUserUseCase = GetCurrentUserUseCase(locator());
  final SignInWithEmailUseCase _signInWithEmailUseCase = SignInWithEmailUseCase(locator());
  final SignUpWithEmailUseCase _signUpWithEmailUseCase = SignUpWithEmailUseCase(locator());
  final SignOutUseCase _signOutUseCase = SignOutUseCase(locator());
  User? _user;

  String? get userId => _user?.uid;

  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_signIn);

    on<SignOutEvent>(_signOut);

    on<CheckAuthEvent>(_onCheckUser);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _signUpWithEmailUseCase.call(event.params);
    result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (data) async {
        emit(Authenticated());
      },
    );
  }

  void _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _signInWithEmailUseCase.call(event.params);
    result.fold(
          (failure) => {
            emit(AuthFailure(failure.message)),
          },
          (data) => {
        emit(Authenticated()),
      },
    );
  }

  Future<void> _onCheckUser(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    final isTokenStored = await locator<TokenStore>().isTokenAvailable();

    if (isTokenStored) {
      emit(Authenticated());
    } else {
      emit(AuthInitial());
    }
  }

  Future<User?> _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    final result = await _currentUserUseCase.call(NoParams());

    result.fold((failure){}, (success){
      _user = success;
      log(userId.toString(), name: 'authbloc userid');
      log(_user!.uid.toString(), name: '_user userid');
    });
    return _user;
  }

  Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var refreshToken = await locator<TokenStore>().getRefreshToken();

    final result = await _signOutUseCase.call(NoParams());
    result.fold(
            (failure) => {
          emit(AuthFailure(failure.message)),
        },
            (data) => {
          emit(AuthInitial()),
        });
  }

}