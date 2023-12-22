// ignore_for_file: use_build_context_synchronously

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
        actions: [
          if(cartItems.isNotEmpty)
          IconButton(
            onPressed: () async {
              final clear = (await showDialog<bool?>(
                  context: context,
                  builder: (ctx){
                    return AlertDialog(
                      icon: Icon(Icons.warning,size: 36,color: Colors.amber.shade800,),
                      iconPadding: const EdgeInsets.all(16).add(const EdgeInsets.only(top: 30)),
                      title: const Text("Empty cart!"),
                      content: const Text("Clear all products in cart ?",textAlign: TextAlign.center,),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Yes")),
                        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No"))
                      ],
                    );
                  },
              ) ?? false);
              if(clear){
                context.read<StoreBloc>().add(StoreEmptyCart());
              }
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      bottomNavigationBar: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          bool empty = state.cart.isEmpty;
          return SafeArea(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: empty ? .3 : 1,
                child: SizedBox(
                  height: kToolbarHeight + 30,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.deepPurple,
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.deepPurple.shade800),
                        onTap: empty ? null : () {
                          debugPrint("check out");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: DefaultTextStyle(
                                style: const TextStyle(color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${cartItems.length} ${cartItems.length == 1 ? "item" : "items"}"),
                                    Text("AED ${state.cartTotal.toStringAsFixed(2)}"),
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(child: Text("CHECKOUT",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),)),
                            Flexible(
                              child: Container(
                                height: 30,
                                width: 40,
                                decoration: ShapeDecoration(
                                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.arrow_forward,color: Colors.black,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
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