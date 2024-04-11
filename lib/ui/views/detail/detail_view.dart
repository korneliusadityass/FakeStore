import 'package:appsmobile/core/networks/detail/detail_product_network.dart';
import 'package:appsmobile/core/view_model/detail/detail_product_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/loading.dart';
import 'package:appsmobile/ui/shared/unfocus_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailProductParam {
  DetailProductParam({
    required this.id,
    required this.mode,
  });

  final int? id;
  final String? mode;
}

class DetailProduct extends ConsumerStatefulWidget {
  const DetailProduct({
    super.key,
    required this.param,
  });

  final DetailProductParam param;

  @override
  ConsumerState<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends ConsumerState<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailPageModel>(
        model: DetailPageModel(
          getDetailProduct: ref.read(getDataProductContent),
          id: widget.param.id!,
        ),
        onModelReady: (DetailPageModel model) => model.initModel(),
        builder: (_, DetailPageModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: UnfocusHelper(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Text(model.daftarproduct[widget.param.id!].title),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
