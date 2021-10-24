import 'package:i_talent/core/helper/push_notifications_helper.dart';
import 'package:i_talent/core/network/auth_info_provider.dart';
import 'package:i_talent/core/use_case/use_case.dart';
import 'package:i_talent/feature/authorization/data/datasource/remote_data_source.dart';
import 'package:i_talent/feature/authorization/domain/repository/authorization_repository.dart';
import 'package:i_talent/feature/dictionaries/domain/use_case/update_dictionaries_use_case.dart';
import 'package:i_talent/feature/main_data/domain/repository/main_repository.dart';
import 'package:i_talent/feature/user_info/data/model/converter/user_converter.dart';
import 'package:i_talent/feature/user_info/domain/entity/user_entity.dart';
import 'package:i_talent/feature/user_info/domain/use_case/save_user_info.dart';

class AuthorizationRepositoryImpl implements AuthorizationRepository {
  final AuthorizationRemoteDataSource remoteDataSource;
  final AuthInfoProvider authInfoProvider;
  final SaveUserInfoUseCase saveUserInfoUseCase;
  final UpdateDictionariesUseCase updateDictionariesUseCase;
  final MainRepository mainRepository;
  final PushNotificationsHelper pushNotificationsHelper;

  AuthorizationRepositoryImpl({
    required this.remoteDataSource,
    required this.authInfoProvider,
    required this.saveUserInfoUseCase,
    required this.updateDictionariesUseCase,
    required this.mainRepository,
    required this.pushNotificationsHelper,
  });

  @override
  Future<UserEntity> login(String login, String password) async {
    final fcmToken = await pushNotificationsHelper.getToken();
    final result = await remoteDataSource.login(login: login, password: password, fcmToken: fcmToken);
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    await saveUserInfoUseCase(SaveUserInfoUseCaseParams(user: user));
    return await _onSuccessLogin(user);
  }

  @override
  Future<UserEntity> registration(String login, String password) async {
    final fcmToken = await pushNotificationsHelper.getToken();
    final result = await remoteDataSource.registration(login: login, password: password, fcmToken: fcmToken);
    return convertUserRemote(result, await mainRepository.getProjectDictionaries());
  }

  @override
  Future<UserEntity> smsConfirm(String login, String code) async {
    final result = await remoteDataSource.smsConfirmation(login, code);
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    return await _onSuccessLogin(user);
  }

  @override
  Future<void> smsRepeat(String login) async {
    await remoteDataSource.smsRepeat(login);
  }

  @override
  Future<UserEntity> changePassword({required String login, required String password, required String token}) async {
    final result = await remoteDataSource.changePassword(login: login, password: password, code: token);
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    return await _onSuccessLogin(user);
  }

  Future<UserEntity> _onSuccessLogin(UserEntity user) async{
    await saveUserInfoUseCase(SaveUserInfoUseCaseParams(user: user));
    await updateDictionariesUseCase(EmptyUsecaseParams());
    return user;
  }

  @override
  Future<void> prolongToken() async {
    final result = await remoteDataSource.prolongToken();
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    await _onSuccessLogin(user);
  }

  @override
  Future<void> logout() async{
    await authInfoProvider.deleteToken();
  }

  @override
  Future<UserEntity> loginByFB(String id, String token) async{
    final result = await remoteDataSource.loginByFb(id, token);
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    await _onSuccessLogin(user);
    return user;
  }

  @override
  Future<UserEntity> loginByGoogle(String id, String token) async{
    final result = await remoteDataSource.loginByGoogle(id, token);
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    await _onSuccessLogin(user);
    return user;
  }

  @override
  Future<UserEntity> loginByApple(String id, String token, String code) async{
    final result = await remoteDataSource.loginByApple(id, token, code);
    await authInfoProvider.setToken(result.jwtToken);
    final user = convertUserRemote(result.user, await mainRepository.getProjectDictionaries());
    await _onSuccessLogin(user);
    return user;
  }

  @override
  Future<void> loginByPhone(String login) async{
    final fcmToken = await pushNotificationsHelper.getToken();
    await remoteDataSource.loginByPhone(login: login,fcmToken: fcmToken);
  }
}
