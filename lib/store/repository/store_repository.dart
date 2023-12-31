import 'package:dio/dio.dart';

import '../store.dart';

class StoreRepository{
  final Dio _client = Dio(BaseOptions(
    baseUrl: 'https://fakestoreapi.com/products'
  ));

  Future<List<Product>> getProducts() async{
    final response = await _client.get('');
    return (response.data as List).map((json) => Product.fromJSON(json)).toList();
  }
}