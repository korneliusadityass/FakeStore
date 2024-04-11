import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'get_detail_api.g.dart';

@RestApi()
abstract class GetDataProductApi {
  factory GetDataProductApi(Dio dio, {String baseUrl}) = _GetDataProductApi;

  @GET('products/{id}')
  Future<HttpResponse<dynamic>> getDataProductContent(
    @Path('id') int id,
    @Header('Accept') String accept,
  );
}