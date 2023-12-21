abstract class StoreEvent {
  const StoreEvent();
}

class StoreProductsRequested extends StoreEvent{}

class StoreProductsAddedToCart extends StoreEvent{
  StoreProductsAddedToCart(this.cartId);
  final int cartId;
}

class StoreProductsRemovedFromCart extends StoreEvent{
  StoreProductsRemovedFromCart(this.cartId);
  final int cartId;
}
