part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartBlocState {}

abstract class CartActionState extends CartBlocState {}

final class CartBlocInitial extends CartBlocState {}

class CartSuccesState extends CartBlocState {
  final List<ProductModel> cartItems;

  CartSuccesState({required this.cartItems});
}
