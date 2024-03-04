import 'package:bloc2/features/cart/bloc/cart_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/ui/product_tile_widget.dart';
import 'cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBlocBloc cartBlocBloc = CartBlocBloc();

  @override
  void initState() {
    cartBlocBloc.add(CartInitialEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart item"),
      ),
      body: BlocConsumer<CartBlocBloc, CartBlocState>(
        bloc: cartBlocBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) {
          return current is! CartActionState;
        },
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccesState:
              final successState = state as CartSuccesState;
              return ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) {
                  return CartTileWidget(
                      cartBlocBloc: cartBlocBloc,
                      productModel: successState.cartItems[index]);
                },
              );
          }

          return Container();
        },
      ),
    );
  }
}
