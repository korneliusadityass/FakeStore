import 'package:appsmobile/core/api/get_data/get_data_api.dart';
import 'package:appsmobile/core/model/error/error_response.dart';
import 'package:appsmobile/core/model/get_data/list_products_model.dart';
import 'package:appsmobile/core/services/dio_service.dart';
import 'package:appsmobile/core/util/eror_utils.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

final getDataContent = Provider<GetDataContentService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return GetDataContentService(
    dio.getDio(domainType: DomainType.account),
  );
});

class GetDataContentService {
  GetDataContentService(
    Dio dio,
  ) : api = GetDataApi(dio);
  final GetDataApi api;

  Future<Either<Failure, GetDataContent>> getData() async {
    try {
      final HttpResponse<dynamic> responses = await api.getDataContent(
        'application/json',
      );
      if (responses.isSuccess) {
        return Right<Failure, GetDataContent>(
          GetDataContent.fromJson(
            responses.data,
          ),
        );
      }
      return ErrorUtils<GetDataContent>().handleDomainError(responses);
    } catch (e) {
      return ErrorUtils<GetDataContent>().handleError(e);
    }
  }
}
