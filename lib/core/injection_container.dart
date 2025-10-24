import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter_clean_riverpod/features/notes/data/repository/note_local_repository_impl.dart';
import 'package:flutter_clean_riverpod/features/notes/data/repository/notes_remote_repository_impl.dart';
import 'package:flutter_clean_riverpod/features/notes/data/services/notes_api_service.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/note_local_repository.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/repository/notes_remote_repository.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/create_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/delete_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/get_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/insert_all_local_notes_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/local/update_local_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/create_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/delete_note_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/fetch_notes_use_case.dart';
import 'package:flutter_clean_riverpod/features/notes/domain/usecase/remote/update_note_use_case.dart';
import 'package:flutter_clean_riverpod/shared/data/local/database_helper.dart';
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
    ..registerLazySingleton<NotesApiService>(
      () => NotesApiService(getIt()),
    )

    // Repositories
    ..registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt()))
    ..registerSingleton<NoteLocalRepository>(NoteLocalRepositoryImpl(getIt()))
    ..registerSingleton<NotesRepository>(NotesRepositoryImpl(getIt(), getIt()))

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
    ..registerLazySingleton<FetchNotesUseCase>(
      () => FetchNotesUseCase(getIt()),
    )
    ..registerLazySingleton<CreateNoteUseCase>(
      () => CreateNoteUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(getIt()),
    )
    ..registerLazySingleton<CreateLocalNoteUseCase>(
      () => CreateLocalNoteUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteLocalNoteByIdUseCase>(
      () => DeleteLocalNoteByIdUseCase(getIt()),
    )
    ..registerLazySingleton<GetLocalNotesUseCase>(
      () => GetLocalNotesUseCase(getIt()),
    )
    ..registerLazySingleton<InsertAllLocalNotesUseCase>(
      () => InsertAllLocalNotesUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateLocalNoteUseCase>(
      () => UpdateLocalNoteUseCase(getIt()),
    )
    ..registerLazySingleton<DeleteAllNotesUseCase>(
          () => DeleteAllNotesUseCase(getIt()),
    )
  ;
}
