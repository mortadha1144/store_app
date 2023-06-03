import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model/product_model.dart';
import 'package:store_app/screens/update_product_screen/widgets/custom_button.dart';
import 'package:store_app/screens/update_product_screen/widgets/custom_text_field.dart';
import 'package:store_app/services/update_service.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  static String id = 'updateProduct';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String? productName, desc, image, price;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Product',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  onChanged: (valu) {
                    productName = valu;
                  },
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (valu) {
                    desc = valu;
                  },
                  hintText: 'Description',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  inputType: TextInputType.number,
                  onChanged: (valu) {
                    price = valu;
                  },
                  hintText: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (valu) {
                    image = valu;
                  },
                  hintText: 'Image',
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Update',
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    await updateProduct(product);
                    try {
                      print('success');
                    } catch (e) {
                      print(e.toString());
                    }
                    isLoading = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
        id: product.id!,
        title: productName ?? product.title!,
        price: price ?? product.price.toString(),
        description: desc ?? product.description!,
        image: image ?? product.image!,
        category: product.category!);
  }
}
