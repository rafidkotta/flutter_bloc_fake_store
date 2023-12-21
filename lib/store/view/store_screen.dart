import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/product_card.dart';
import '../store.dart';

class StoreScreen extends StatelessWidget{
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Center(
     child: BlocBuilder<StoreBloc, StoreState>(
       builder: (context, state) {
         if(state.status == StoreRequest.requestInProgress){
           return const CircularProgressIndicator();
         }
         if(state.status == StoreRequest.requestFailure){
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text("Problem loading products"),
               const SizedBox(height: 10,),
               OutlinedButton(
                 onPressed: (){
                   context.read<StoreBloc>().add(StoreProductsRequested());
                 },
                 child: const Text("Retry"),
               )
             ],
           );
         }
         if(state.status == StoreRequest.unknown){
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Icon(Icons.shop_outlined),
               const SizedBox(height: 10,),
               const Text("No products to view"),
               const SizedBox(height: 10,),
               OutlinedButton(
                 onPressed: (){
                   context.read<StoreBloc>().add(StoreProductsRequested());
                 },
                 child: const Text("Retry"),
               )
             ],
           );
         }
         if(state.status == StoreRequest.requestSuccess){
           return GridView.builder(
               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                 maxCrossAxisExtent: 250,
                 childAspectRatio: .8,
               ),
               itemCount: state.products.length,
               itemBuilder: (context,index){
                 final product = state.products[index];
                 final inCart = state.cart.contains(product.id);
                 return ProductCard(product: product,inCart: inCart,);
               }
           );
         }
         return Container();
       },
     ),
   );
  }

}