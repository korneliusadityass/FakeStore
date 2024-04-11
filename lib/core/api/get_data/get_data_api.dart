import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'get_data_api.g.dart';

@RestApi()
abstract class GetDataApi {
  factory GetDataApi(Dio dio, {String baseUrl}) = _GetDataApi;

  @GET('products')
  Future<HttpResponse<dynamic>> getDataContent(
    @Header('Accept') String accept,
  );
}
