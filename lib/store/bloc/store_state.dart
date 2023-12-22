import 'package:equatable/equatable.dart';

import '../models/product.dart';

class StoreState extends Equatable {
  final StoreRequest status;
  final Set<int> cart;
  final List<Product> products;

  const StoreState({
    this.products = const [],
    this.status = StoreRequest.unknown,
    this.cart = const {},
  });

  StoreState copyWith({
    StoreRequest? status,
    Set<int>? cart,
    List<Product>? products,
  }) => StoreState(
    products: products ?? this.products,
    cart: cart ?? this.cart,
    status: status ?? this.status,
  );

  double get cartTotal{
    return products.where((element) => cart.contains(element.id)).toList().fold(0, (previousValue, element) => previousValue + element.price);
  }

  @override
  List<Object?> get props => [status,cart,products];
}

enum StoreRequest{
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure
}
