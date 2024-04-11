import 'package:appsmobile/core/api/get_data/get_data_api.dart';
import 'package:appsmobile/core/model/error/error_response.dart';
import 'package:appsmobile/core/model/get_data/list_products_model.dart';
import 'package:appsmobile/core/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  // Future<Either<Failure, GetDataContent>> getData() async {
  //   try {
  //     final HttpResponse<dynamic> responses = await api.getDataContent(
  //       'application/json',
  //     );
  //     if (responses.isSuccess) {
  //       return Right<Failure, GetDataContent>(
  //         GetDataContent.fromJson(
  //           responses.data,
  //         ),
  //       );
  //     }
  //     return ErrorUtils<GetDataContent>().handleDomainError(responses);
  //   } catch (e) {
  //     return ErrorUtils<GetDataContent>().handleError(e);
  //   }
  // }
  Future<Either<Failure, List<GetDataContent>>> getData() async {
    try {
      final response = await api.getDataContent('application/json');
      if (response.isSuccess == 200) {
        return Left(Failure(message: "Failed to fetch data"));
      } else {
        final List<GetDataContent> data = (response.data as List).map((json) => GetDataContent.fromJson(json)).toList();
        return Right(data);
      }
    } catch (e) {
      return Left(Failure(message: "An error occurred: $e"));
    }
  }
}
