import 'package:app_agendamento/core/device/app_secure_storage.dart';
import 'package:app_agendamento/features/auth/data/auth_datasource.dart';
import 'package:app_agendamento/features/auth/data/results/validate_token_failed.dart';
import '../../../core/helpers/result.dart';
import '../models/user.dart';
import 'results/login_failure.dart';

class AuthRepository {
  AuthRepository(this._datasource, this._appSecureStorage);

  final AuthDatasource _datasource;
  final AppSecureStorage _appSecureStorage;

  User? user;

  Future<Result<LoginFailure, User>> login({required String email, required String password}) async {
    final result = await _datasource.login(email: email, password: password);

    ///Exemplo para mostrar que podemos ter acesso a exception também no repository
    if(result case Success(value: final user)) {
      this.user = user;
    }

    return result;
  }

  Future<Result<ValidateTokenFailed, User>> validateToken() async {
    final token = await _appSecureStorage.getSessionToken();
    if(token == null) {
      return const Failure(ValidateTokenFailed.invalidToken);
    }
    final result = await _datasource.validateToken(token);
    if(result case Success(value: final user)) {
      this.user = user;
    }

    return result;
  }
}