import 'package:evently/domain/repositories/auth_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/ui/auth/cubit/auth_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<AuthFormState> {
  LoginCubit(this._authRepository) : super(const AuthFormState());

  final AuthRepository _authRepository;

  String _email = '';
  String _password = '';

  /// Stores the typed email.
  void onEmailChanged(String text) => _email = text.trim();

  /// Stores the typed password.
  void onPasswordChanged(String text) => _password = text;

  /// Signs in with the typed email and password.
  Future<void> login() {
    return _signIn(
      () => _authRepository.login(email: _email, password: _password),
    );
  }

  /// Signs in with a Google account.
  Future<void> loginWithGoogle() {
    return _signIn(_authRepository.loginWithGoogle);
  }

  /// Runs [signInAction] and emits loading, then the user or the failure.
  Future<void> _signIn(Future<MyUser> Function() signInAction) async {
    if (state.isLoading) return;
    emit(const AuthFormState(isLoading: true));
    try {
      final MyUser user = await signInAction();
      if (isClosed) return;
      emit(AuthFormState(user: user));
    } catch (e) {
      if (isClosed) return;
      emit(AuthFormState(failure: AppFailure.fromError(e)));
    }
  }
}
