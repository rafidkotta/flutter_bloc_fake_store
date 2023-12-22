import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'store/store.dart';
import 'widget/theme_switcher.dart';

class StoreHome extends StatefulWidget {
  const StoreHome({super.key});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {

  @override
  void initState() {
    context.read<StoreBloc>().add(StoreProductsRequested());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 50,),
            Icon(Icons.shopping_basket),
            SizedBox(width: 8,),
            Text("Fake store",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
        actions: const [
          ThemeSwitch(),
        ],
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => BlocProvider.value(value: BlocProvider.of<StoreBloc>(context), child: const CartScreen())),);
            },
            child: const Icon(Icons.shopping_bag,color: Colors.white,),
          ),
          BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if(state.cart.isEmpty){
                return Container();
              }
              return Positioned(
                right: -4,
                bottom: 40,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: Text("${state.cart.length}"),
                ),
              );
            },
          ),
        ],
      ),
      body: const StoreScreen(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}