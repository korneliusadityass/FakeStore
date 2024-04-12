import 'package:appsmobile/core/app_constants/route.dart';
import 'package:appsmobile/core/networks/get_data/list_products_network.dart';
import 'package:appsmobile/core/view_model/Home/dashboard_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/loading.dart';
import 'package:appsmobile/ui/shared/spacing.dart';
import 'package:appsmobile/ui/views/cart_view.dart';
import 'package:appsmobile/ui/views/detail/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    List<AddProduct> addCartProduct = [];
    return ViewModel<DashboardPageModel>(
        model: DashboardPageModel(
          getDashboard: ref.read(getDataContent),
        ),
        onModelReady: (DashboardPageModel model) => model.initModel(),
        builder: (_, DashboardPageModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'FAKE STORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cart(
                            addCartProduct: addCartProduct,
                            onQuantityChanged: (product, newQuantity) {
                              // Update the quantity of the product in the cart
                              setState(() {
                                product.quantity = newQuantity;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('asset/image/NO8hx.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: model.daftarproduct.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                            mainAxisExtent: 240,
                          ),
                          padding: const EdgeInsets.all(24),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.detailPage,
                                  arguments: DetailProductParam(
                                    id: model.daftarproduct[index].id,
                                    mode: 'view',
                                  ),
                                );
                              },
                              child: Card(
                                shadowColor: Colors.black,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                            child: Image.network(
                                              model.daftarproduct[index].image,
                                              height: 134,
                                              scale: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacings.verSpace(12),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.daftarproduct[index].title.length <= 15
                                                    ? model.daftarproduct[index].title
                                                    : '${model.daftarproduct[index].title.substring(0, 15)}...',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                model.daftarproduct[index].category,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.orange[600],
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    '${model.daftarproduct[index].rating.rate} / ${model.daftarproduct[index].rating.count}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '\$ ${model.daftarproduct[index].price}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
