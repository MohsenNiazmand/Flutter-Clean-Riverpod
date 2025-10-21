import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/home/domain/usecase/fetch_home_use_case.dart';
import 'package:flutter_clean_riverpod/shared/data/model/api_response.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';


final homeDataProvider = StateProvider<dynamic>((ref) =>null);


@Riverpod(keepAlive: true)
class HomeP extends _$HomeP {

  @override
  DataState<ApiResponse<dynamic>> build() {
    return const DataInitial();
  }


  Future<void> fetchHome() async{
    final homeData=ref.read(homeDataProvider.notifier).state;
    if(homeData==null){
      state = const DataLoading();
      final response = await getIt<FetchHomeUseCase>().call();
      await response.fold((l) {
        state = DataFailed(l);
      }, (r) async {
        ref.read(homeDataProvider.notifier).state=r.data;
        state = DataSuccess(r);
      });
    }
  }



}
