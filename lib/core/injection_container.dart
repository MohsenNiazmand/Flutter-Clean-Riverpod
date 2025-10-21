import 'package:flutter_clean_riverpod/config/api/interceptor.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_riverpod/features/auth/data/services/auth_api_service.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/send_activation_code_usecase.dart';
import 'package:flutter_clean_riverpod/features/auth/domain/usecases/send_reset_password_email_usecase.dart';
import 'package:flutter_clean_riverpod/features/home/data/repository/home_repository_impl.dart';
import 'package:flutter_clean_riverpod/features/home/data/services/home_api_service.dart';
import 'package:flutter_clean_riverpod/features/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_riverpod/features/home/domain/usecase/fetch_home_use_case.dart';
import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
import 'package:flutter_clean_riverpod/shared/data/repository/note_repository_impl.dart';
import 'package:flutter_clean_riverpod/shared/domain/repository/note_repository.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/delete_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/get_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/insert_all_notes_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/save_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/domain/usecase/note/update_note_use_case.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies({
  required AndroidOptions androidOptions,
  BuildContext? context,
}) async {
  getIt
    ..registerLazySingleton(
      () => MyInterceptor(
        dio: Dio(),
      ),
    )
    // Configure Dio with interceptors for requests logging and auth
    ..registerLazySingleton<Dio>(
      () => Dio()
        ..interceptors.add(getIt<MyInterceptor>())
        ..interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true)),
    )

    // Secure storage and wrappers
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<SecureStorage>(
      () => SecureStorage(storage: getIt()),
    )
    ..registerLazySingleton<DatabaseHelper>(DatabaseHelper.new)

    // API services
    ..registerLazySingleton<AuthApiService>(
      () => AuthApiService(getIt()),
    )
    ..registerLazySingleton<HomeApiService>(
      () => HomeApiService(getIt()),
    )

    // Repositories
    ..registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt(), getIt()))
    ..registerSingleton<NoteRepository>(NoteRepositoryImpl(getIt()))
    ..registerSingleton<HomeRepository>(HomeRepositoryImpl(getIt()))

    // Use cases
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt()),
    )
    ..registerLazySingleton<SendActivationTokenUseCase>(
      () => SendActivationTokenUseCase(getIt()),
    )
    ..registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt()),
    )
    ..registerLazySingleton<SendResetPasswordEmailUseCase>(
      () => SendResetPasswordEmailUseCase(getIt()),
    )
    ..registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt()),
    )
    ..registerLazySingleton<SaveNoteUseCase>(
      () => SaveNoteUseCase(getIt()),
    )
    ..registerLazySingleton<GetNotesUseCase>(
      () => GetNotesUseCase(getIt()),
    )
    ..registerLazySingleton<GetNoteByIdUseCase>(
      () => GetNoteByIdUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteNoteByIdUseCase>(
      () => DeleteNoteByIdUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteAllNotesUseCase>(
      () => DeleteAllNotesUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(getIt()),
    )
    ..registerLazySingleton<InsertAllNotesUseCase>(
      () => InsertAllNotesUseCase(getIt()),
    )
    ..registerLazySingleton<FetchHomeUseCase>(
      () => FetchHomeUseCase(getIt()),
    );
}
