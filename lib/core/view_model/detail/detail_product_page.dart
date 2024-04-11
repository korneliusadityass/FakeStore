import 'package:appsmobile/core/model/detail_product/detail_product_model.dart';
import 'package:appsmobile/core/networks/detail/detail_product_network.dart';
import 'package:appsmobile/core/view_model/base_view_model.dart';

class DetailPageModel extends BaseViewModel {
  DetailPageModel({
    required GetDataProductContentService getDetailProduct,
    required int id,
  })  : _getDetailProduct = getDetailProduct,
        _id = id;

  final GetDataProductContentService _getDetailProduct;
  final int _id;

  GetDataProductContent? _daftarproduct;
  GetDataProductContent? get daftarproduct => _daftarproduct;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchDataProduct();
    setBusy(false);
  }

  Future<void> _fetchDataProduct() async {
    // final id = 0;
    final response = await _getDetailProduct.getDataProduct(id: _id);
    response.fold(
      (failure) {
        print('Error occurred: ${failure.message}');
      },
      (getDataContent) {
        _daftarproduct = getDataContent;
        notify();
      },
    );
  }
}
