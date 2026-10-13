import 'package:evently/domain/repositories/auth_repository.dart';
import 'package:evently/models/app_failure.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/ui/auth/cubit/auth_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<AuthFormState> {
  RegisterCubit(this._authRepository) : super(const AuthFormState());

  final AuthRepository _authRepository;

  String _name = '';
  String _email = '';
  String _password = '';

  /// The typed password, used to validate the confirmation field.
  String get password => _password;

  /// Stores the typed name.
  void onNameChanged(String text) => _name = text.trim();

  /// Stores the typed email.
  void onEmailChanged(String text) => _email = text.trim();

  /// Stores the typed password.
  void onPasswordChanged(String text) => _password = text;

  /// Creates the account and emits loading, then the user or the failure.
  Future<void> register() async {
    if (state.isLoading) return;
    emit(const AuthFormState(isLoading: true));
    try {
      final MyUser user = await _authRepository.register(
        name: _name,
        email: _email,
        password: _password,
      );
      if (isClosed) return;
      emit(AuthFormState(user: user));
    } catch (e) {
      if (isClosed) return;
      emit(AuthFormState(failure: AppFailure.fromError(e)));
    }
  }
}
