import 'package:appsmobile/core/model/get_data/list_products_model.dart';
import 'package:appsmobile/core/networks/get_data/list_products_network.dart';
import 'package:appsmobile/core/view_model/base_view_model.dart';

class DashboardPageModel extends BaseViewModel {
  DashboardPageModel({
    required GetDataContentService getDashboard,
  }) : _getDashboard = getDashboard;

  final GetDataContentService _getDashboard;

  List<GetDataContent> _daftarproduct = [];
  List<GetDataContent> get daftarproduct => _daftarproduct;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchDataProduct();
    setBusy(false);
  }

  Future<void> _fetchDataProduct() async {
    final response = await _getDashboard.getData();
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

  // Future<void> _fetchDataProduct() async {
  //   final response = await _getDashboard.getData();
  //   if (response.isRight) {
  //     _daftarproduct = response.right;
  //     notify();
  //   }
  //   print('response = $response');
  // }
}
