part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initCar();

  await Firebase.initializeApp();

 Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'cars'),
  );
 
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
   serviceLocator.registerLazySingleton(
    () => CloudinaryPublic('mst1993-hb', 'flutter-car', cache: false),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
      
    )
    ..registerFactory(
      () => UserProfileUpload(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(), 
        userProfileUpload: serviceLocator(),
      ),
    );
}

void _initCar() {
  serviceLocator
    ..registerFactory<CarRemoteDataSource>(
      () => CarRemoteDataSourceImpl(
        serviceLocator<FirebaseFirestore>(),
        serviceLocator<CloudinaryPublic>(),
      ),
    )
    ..registerFactory<CarLocalDataSource>(
      () => CarLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<CarRepository>(
      () => CarRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadCar(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllCars(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => CarBloc(
        uploadCar: serviceLocator(),
        getAllCars: serviceLocator(),
      ),
    );
}
