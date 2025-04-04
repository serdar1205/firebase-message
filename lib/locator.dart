import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/core/utils/local/token_store.dart';
import 'package:firebase_message/features/data/datasources/remote/message_remote_datasource.dart';
import 'package:firebase_message/features/presentation/blocs/messages_bloc/messages_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network.dart';
import 'features/data/datasources/remote/auth_remote_datasource.dart';
import 'features/data/datasources/remote/user_remote_datasource.dart';
import 'features/data/reposotories/auth_repository_impl.dart';
import 'features/data/reposotories/message_repository_impl.dart';
import 'features/data/reposotories/user_repository_impl.dart';
import 'features/domain/reposotories/auth_repository.dart';
import 'features/domain/reposotories/message_repository.dart';
import 'features/domain/reposotories/user_repository.dart';
import 'features/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import 'features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'features/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';
import 'features/domain/usecases/user_usecases/get_all_users_usecase.dart';
import 'features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/presentation/blocs/users_bloc/users_bloc.dart';

final locator = GetIt.instance;
String documentsDir = '';

Future<void> initLocator() async {
  final secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  locator.registerLazySingletonAsync<FlutterSecureStorage>(() async => secureStorage);

  // const secureStorage = FlutterSecureStorage(
  //   aOptions: AndroidOptions(encryptedSharedPreferences: true),
  // );
  // locator.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  locator.registerLazySingleton<TokenStore>(
    () => TokenStore(locator()),
  );

  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(() {
    final instance = FirebaseFirestore.instance;
    instance.settings = const Settings(persistenceEnabled: true);
    return instance;
  });

  // locator.registerLazySingleton<FirebaseFirestore>(
  //     () => FirebaseFirestore.instance);
///Data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDatasourceImpl(firebaseAuth: locator(),firestore: locator()));

  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(firebaseAuth: locator(),firestore: locator()));

  locator.registerLazySingleton<MessageRemoteDatasource>(
      () => MessMessageRemoteDatasourceImpl(firebaseAuth: locator(),firestore: locator()));
///repo
  locator.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: locator(), remoteDataSource: locator()));

  locator.registerLazySingleton<UserRepository>(() =>
      UserRepositoryImpl(networkInfo: locator(), remoteDataSource: locator()));

  locator.registerLazySingleton<MessageRepository>(() =>
      MessageRepositoryImpl(networkInfo: locator(), remoteDataSource: locator()));

  ///usecase
  locator.registerLazySingleton(() => GetCurrentUserUseCase(locator()));

  locator.registerLazySingleton(() => SignInWithEmailUseCase(locator()));

  locator.registerLazySingleton(() => SignOutUseCase(locator()));

  locator.registerLazySingleton(() => SignUpWithEmailUseCase(locator()));

  locator.registerLazySingleton(() => GetAllUsersUseCase(locator()));
///bloc
//   locator.registerSingleton(AuthBloc());
//   locator.registerSingleton(UsersBloc());
//   locator.registerSingleton(MessagesBloc());
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());
  locator.registerLazySingleton<UsersBloc>(() => UsersBloc());
  locator.registerLazySingleton<MessagesBloc>(() => MessagesBloc());
}
