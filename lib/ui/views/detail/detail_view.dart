import 'package:appsmobile/core/networks/detail/detail_product_network.dart';
import 'package:appsmobile/core/view_model/detail/detail_product_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/spacing.dart';
import 'package:appsmobile/ui/shared/unfocus_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProduct {
  AddProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  final int id;
  final String title;
  final String image;
  final double price;
}

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
  List<AddProduct> addCartProduct = [];
  @override
  Widget build(BuildContext context) {
    return ViewModel<DetailPageModel>(
      model: DetailPageModel(
        getDetailProduct: ref.read(getDataProductContent),
        id: widget.param.id!,
      ),
      onModelReady: (DetailPageModel model) => model.initModel(),
      builder: (_, DetailPageModel model, __) {
        return UnfocusHelper(
          child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            body: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/image/NO8hx.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                },
                child: model.busy
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      model.daftarproduct!.image,
                                      height: 250,
                                    ),
                                  ],
                                ),
                              ),
                              Spacings.verSpace(15),
                              Text(
                                '\$ ${model.daftarproduct!.price}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacings.verSpace(15),
                              Text(
                                model.daftarproduct!.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacings.verSpace(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.orange[600],
                                      ),
                                      Spacings.horSpace(5),
                                      Text(
                                        '${model.daftarproduct!.rating.rate} / ${model.daftarproduct!.rating.count}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    model.daftarproduct!.category,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Spacings.verSpace(15),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(model.daftarproduct!.description),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              // key: const Key("Add To Chat"),
              shape: const CircleBorder(),
              onPressed: () {
                addToCart(AddProduct(
                    id: model.daftarproduct!.id,
                    title: model.daftarproduct!.title,
                    image: model.daftarproduct!.image,
                    price: model.daftarproduct!.price));
              },
              backgroundColor: Colors.cyan[200],
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.black,
                size: 31.5,
              ),
            ),
          ),
        );
      },
    );
  }

  void addToCart(AddProduct addProduct) {
    setState(() {
      addCartProduct.add(addProduct);
    });
  }
}
