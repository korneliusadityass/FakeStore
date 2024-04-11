import 'package:appsmobile/core/api/detail_product/get_detail_api.dart';
import 'package:appsmobile/core/model/detail_product/detail_product_model.dart';
import 'package:appsmobile/core/model/error/error_response.dart';
import 'package:appsmobile/core/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getDataProductContent = Provider<GetDataProductContentService>((ref) {
  final DioService dio = ref.read(dioProvider);
  return GetDataProductContentService(
    dio.getDio(domainType: DomainType.account),
  );
});

class GetDataProductContentService {
  GetDataProductContentService(
    Dio dio,
  ) : api = GetDataProductApi(dio);
  final GetDataProductApi api;

  Future<Either<Failure, GetDataProductContent>> getDataProduct(
      {required int id}) async {
    try {
      final response = await api.getDataProductContent(
        id,
        'application/json',
      );
      if (response.isSuccess == 200) {
        return Left(Failure(message: "Failed to fetch data"));
      } else {
        final GetDataProductContent data =
            GetDataProductContent.fromJson(response.data);
        return Right(data);
      }
    } catch (e) {
      return Left(Failure(message: "An error occurred: $e"));
    }
  }
}
