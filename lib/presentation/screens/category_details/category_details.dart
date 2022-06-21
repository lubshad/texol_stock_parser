import 'package:flutter/material.dart';
import 'package:texol_stock_parser/utils/constants.dart';

import 'components/criteria_item.dart';

class StockCategoryDetails extends StatelessWidget {
  const StockCategoryDetails({
    Key? key,
    required this.stockCategory,
  }) : super(key: key);

  final dynamic stockCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stockCategory["name"]),
              Text(
                stockCategory["tag"],
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: stockCategory["color"]),
              ),
            ],
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(defaultPadding),
          itemCount: stockCategory["criteria"].length,
          itemBuilder: (context, index) {
            final criteria = stockCategory["criteria"][index];
            return CriteriaItem(
              criteria: criteria,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: defaultPaddingLarge * 2,
              alignment: Alignment.centerLeft,
              child: const Text("and"),
            );
          },
        ));
  }
}
