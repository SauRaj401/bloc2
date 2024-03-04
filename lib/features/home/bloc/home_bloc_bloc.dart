import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc2/data/cart_items.dart';
import 'package:bloc2/data/wishlist_item.dart';
import 'package:meta/meta.dart';

import '../../../data/products.dart';
import '../model/products.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    // on<HomeBlocEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);

    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);

    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeLoadingState());

    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: Products.groceryProducts
            .map((e) => ProductModel(
                id: e['id'] ?? "null id",
                name: e['name'] ?? "null name",
                description: e['description'] ?? "null desc",
                price: e['price'] ?? "null price",
                imageUrl: e['imageURL'] ?? "null image"))
            .toList()));
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
      HomeProductWishListButtonClickedEvent event,
      Emitter<HomeBlocState> emit) {
    print("wishlist  product clicked");
    wishListItem.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeBlocState> emit) {
    print("cart  product clicked");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeBlocState> emit) {
    print("wishlist  navigate clicked button navigate event");
    emit(HomeNavigateToWishistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeBlocState> emit) {
    print("cart  nagivate clicked button navigate event");
    emit(HomeNavigateToCartPageActionState());
  }
}
