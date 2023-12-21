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
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: () async {
                      // final list = await showModalBottomSheet<PurchaseList?>(
                      //     context: context,
                      //     builder: (_){
                      //       return const PurchaseListDialog();
                      //     },
                      //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusM),topRight: Radius.circular(radiusM))),
                      //     constraints: const BoxConstraints(maxWidth: 700,maxHeight: 400),
                      //     isScrollControlled: true
                      // );
                      // if(list == null){
                      //   return;
                      // }
                      // final item = PurchaseListItem(id: "", offerID: product.id);
                      // showProgressDialog(context);
                      // try{
                      //   final response = await item.add(purchaseList: list.id);
                      //   if(response.success){
                      //     GlobalSnackBar.show(context, "Item added to wishlist".translate,color: Colors.green);
                      //   }else{
                      //     GlobalSnackBar.show(context, response.message.translate,color: Colors.red);
                      //   }
                      // }catch(ex){
                      //   printDebug(ex.toString());
                      // }finally{
                      //   Navigator.of(context,rootNavigator: true).pop();
                      // }
                    },
                    child: const CircleAvatar(
                      radius: 10,
                      child: Icon(Icons.add_shopping_cart_rounded,size: 12,),
                    ),
                  ),
                )
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