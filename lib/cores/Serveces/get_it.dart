import 'package:dio/dio.dart';
import 'package:ecommerce/cores/Serveces/apiService.dart';
import 'package:ecommerce/cores/Serveces/databaseService.dart';
import 'package:ecommerce/cores/Serveces/hivedatabaseservice.dart';
import 'package:ecommerce/cores/Serveces/localdatabaseservice.dart';
import 'package:ecommerce/cores/Serveces/notification/notification_service.dart';
import 'package:ecommerce/feature/Auth/data/authrepoimple.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/domain/repo/mainrepoimple.dart';
import 'package:ecommerce/feature/main/data/repo/payment_repo.dart';
import 'package:ecommerce/feature/main/domain/repo/payment_repo_imple.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Payment_Cubit/payment_cubit.dart';
import 'package:get_it/get_it.dart';

final get_it = GetIt.instance;

void setupget_it() {
  // =========================
  // API
  // =========================

  get_it.registerSingleton<Apiserver>(
    Apiserver(
      dio: Dio(),
    ),
  );

  get_it.registerSingleton<Databaseservce>(
    get_it<Apiserver>(),
  );

  // =========================
  // Local Database
  // =========================

  get_it.registerSingleton<LocalDatabaseService>(
    Hivedatabaseservice(),
  );

  // =========================
  // Notification Service
  // =========================

  get_it.registerSingleton<NotificationService>(
    NotificationService(
      localDatabaseService: get_it<LocalDatabaseService>(),
    ),
  );

  // =========================
  // Auth Repository
  // =========================

  get_it.registerSingleton<Authrepo>(
    Authrepoimple(
      databaseservce: get_it<Databaseservce>(),
      localDatabaseService: get_it<LocalDatabaseService>(),
    ),
  );

  // =========================
  // Main Repository
  // =========================

  get_it.registerSingleton<Mainrepo>(
    Mainrepoimple(
      databaseservce: get_it<Databaseservce>(),
      localDatabaseService: get_it<LocalDatabaseService>(),
    ),
  );

  // =========================
  // Cart Cubit
  // =========================

  get_it.registerFactory<CartCubit>(
    () => CartCubit(
      mainrepo: get_it<Mainrepo>(),
      notificationService: get_it<NotificationService>(),
    ),
  );

  // =========================
  // Payment Repository
  // =========================

  get_it.registerLazySingleton<PaymentRepo>(
    () => PaymentRepoImple(
      get_it<Apiserver>(),
    ),
  );

  // =========================
  // Payment Cubit
  // =========================

  get_it.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      get_it<PaymentRepo>(),
    ),
  );
}