import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../repository/store_repository.dart';
import 'store_event.dart';
import 'store_state.dart';


class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(const StoreState()) {
    on<StoreProductsRequested>(_handleStoreProductsRequested);
    on<StoreProductsAddedToCart>(_handleProductAddedToCart);
    on<StoreProductsRemovedFromCart>(_handleProductRemovedFromCart);
    on<StoreEmptyCart>(_handleEmptyCart);
  }

  final StoreRepository api = StoreRepository();

  Future<void> _handleStoreProductsRequested(
    StoreProductsRequested event,
    Emitter<StoreState> emit,
  ) async {
    try{
      emit(state.copyWith(status: StoreRequest.requestInProgress));
      final response = await api.getProducts();
      emit(state.copyWith(
        status: StoreRequest.requestSuccess,
        products: response,
      ));
    }catch(ex){
      debugPrint(ex.toString());
      emit(
        state.copyWith(status: StoreRequest.requestFailure),
      );
    }
  }

  Future<void> _handleProductAddedToCart(
    StoreProductsAddedToCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cart: {...state.cart,event.cartId}));
  }

  Future<void> _handleProductRemovedFromCart(
    StoreProductsRemovedFromCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(cart: {...state.cart}..remove(event.cartId)));
  }

  Future<void> _handleEmptyCart(
    StoreEmptyCart event,
    Emitter<StoreState> emit,
    ) async {
    emit(state.copyWith(cart: {}));
  }
}
