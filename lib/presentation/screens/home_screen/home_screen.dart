import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:texol_stock_parser/presentation/components/error_message_with_retry.dart';
import 'package:texol_stock_parser/presentation/screens/home_screen/home_controller.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    homeController.getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Scan Parser"),
      ),
      body: AnimatedBuilder(
          animation: homeController,
          builder: (context, child) {
            return NetworkResource(
                errorWidget: Builder(builder: (context) {
                  return ErrorMessageWithRetry(
                      error: homeController.appError!,
                      retry: homeController.retry);
                }),
                error: homeController.appError,
                isLoading: homeController.isLoading,
                child: ListView.separated(
                  itemCount: homeController.stockCategoryList.length,
                  itemBuilder: (context, index) {
                    final stockCategory =
                        homeController.stockCategoryList[index];
                    return ListTile(
                      leading: const Text("•"),
                      onTap: () => Get.toNamed('/category_details',
                          arguments: stockCategory),
                      title: Text(stockCategory["name"]),
                      subtitle: Text(
                        stockCategory["tag"],
                        style: TextStyle(color: stockCategory["color"]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ));
          }),
    );
  }
}
