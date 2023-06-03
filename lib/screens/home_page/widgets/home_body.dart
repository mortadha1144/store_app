import 'package:flutter/material.dart';
import 'package:store_app/models/product_model/product_model.dart';
import 'package:store_app/screens/home_page/widgets/custom_card.dart';
import 'package:store_app/services/all_products_service.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 65,
      ),
      child: FutureBuilder<List<ProductModel>>(
          future: AllProductsService().getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;
              return GridView.builder(
                itemCount: products.length,
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 80,
                ),
                itemBuilder: (context, index) => CustomCard(
                  product: products[index],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
