import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/product_card.dart';
import '../store.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.select<StoreBloc,List<Product>>((store) => store.state.products.where((product) => store.state.cart.contains(product.id)).toList());
    return Scaffold(
      appBar: AppBar(
        title: const Text("My cart"),
      ),
      body: Builder(
        builder: (context) {
          if(cartItems.isEmpty){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Your cart is empty"),
                  const SizedBox(height: 10,),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_shopping_cart_outlined),
                        SizedBox(width: 10,),
                        Text("Add product",overflow: TextOverflow.ellipsis,)
                      ]
                    ),
                  )
                ],
              ),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: .8,
              ),
              itemCount: cartItems.length,
              itemBuilder: (context,index){
                final product = cartItems[index];
                return ProductCard(product: product,inCart: true,);
              }
          );
        }
      ),
    );
  }

}