import 'package:appsmobile/core/networks/get_data/list_products_network.dart';
import 'package:appsmobile/core/view_model/Home/dashboard_page.dart';
import 'package:appsmobile/core/view_model/view_model.dart';
import 'package:appsmobile/ui/shared/loading.dart';
import 'package:appsmobile/ui/shared/spacing.dart';
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
    return ViewModel<DashboardPageModel>(
        model: DashboardPageModel(
          getDashboard: ref.read(getDataContent),
        ),
        onModelReady: (DashboardPageModel model) => model.initModel(),
        builder: (_, DashboardPageModel model, __) {
          return LoadingOverlay(
            isLoading: model.busy,
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  model.initModel();
                },
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 44,
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'FAKE STORE',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: model.daftarproduct.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14.0,
                          crossAxisSpacing: 14.0,
                          mainAxisExtent: 240,
                        ),
                        padding: const EdgeInsets.all(24),
                        itemBuilder: (BuildContext context, int index) {
                          // final productId = model.daftarproduct[index].id;

                          return GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.DetailProduct, arguments: DetailProductParam(),);
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
                                          child: Image.network('model.daftarproduct[index].image'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacings.verySpace(12),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.daftarproduct[index].title.length <= 20
                                                  ? model.daftarproduct[index].title
                                                  : '${model.daftarproduct[index].title.substring(0, 20)}...',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
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
          );
        });
  }
}
