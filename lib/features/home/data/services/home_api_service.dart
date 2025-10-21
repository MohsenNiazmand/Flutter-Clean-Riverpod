
import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET('/index')
  Future<ApiResponse<List<NoteModel>>> fetchHomeData();

}
