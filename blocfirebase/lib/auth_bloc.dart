import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield AuthLoading();
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield Authenticated();
      } on FirebaseAuthException catch (e) {
        yield AuthError(message: e.message ?? 'An error occurred');
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is LogoutEvent) {
      yield AuthLoading();
      try {
        await _firebaseAuth.signOut();
        yield Unauthenticated();
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is SignupEvent) {
      yield AuthLoading();
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield Authenticated();
      } on FirebaseAuthException catch (e) {
        yield AuthError(message: e.message ?? 'An error occurred');
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    } else if (event is ForgotPasswordEvent) {
      yield AuthLoading();
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: event.email);
        yield PasswordResetSent();
      } on FirebaseAuthException catch (e) {
        yield AuthError(message: e.message ?? 'An error occurred');
      } catch (e) {
        yield AuthError(message: e.toString());
      }
    }
  }
}
