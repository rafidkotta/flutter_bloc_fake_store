// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../store/store.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product,this.inCart = false});

  final Product product;
  final bool inCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8,),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(product.image),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(product.title,style: const TextStyle(fontSize: 10),),
                Text("${product.price.toStringAsFixed(0)} USD",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Text("${(product.price + product.id).toDouble().ceil()}",style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough,color: Colors.blueGrey.shade600),),
                    const SizedBox(width: 8,),
                    Text("${getPercent(full: product.price + product.id, partial: product.price).ceil().toInt()} % OFF",style: const TextStyle(fontSize: 10,color: Colors.green,fontWeight: FontWeight.bold),),
                  ],
                ),
                OutlinedButton(
                  onPressed: inCart ? () => _removeFromCart(product.id,context): () => _addToCart(product.id,context),
                  child: Row(
                    children: inCart ? [
                      const Icon(Icons.remove_shopping_cart_outlined,),
                      const SizedBox(width: 10,),
                      const Expanded(child: Text("Remove from cart",overflow: TextOverflow.ellipsis,))
                    ] : [
                      const Icon(Icons.add_shopping_cart_outlined,),
                      const SizedBox(width: 10,),
                      const Text("Add to cart")
                    ],
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  double getPercent({required double full, required double partial}){
    return (((full-partial) / full) * 100).ceilToDouble();
  }

  void _addToCart(int cartID,BuildContext context){
    context.read<StoreBloc>().add(StoreProductsAddedToCart(cartID));
  }

  void _removeFromCart(int cartID,BuildContext context){
    context.read<StoreBloc>().add(StoreProductsRemovedFromCart(cartID));
  }
}