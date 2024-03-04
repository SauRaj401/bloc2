import 'package:bloc2/features/cart/bloc/cart_bloc_bloc.dart';
import 'package:bloc2/features/home/bloc/home_bloc_bloc.dart';
import 'package:bloc2/features/home/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartTileWidget extends StatelessWidget {
  final ProductModel productModel;
  final CartBlocBloc cartBlocBloc;
  const CartTileWidget(
      {super.key, required this.productModel, required this.cartBlocBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productModel.imageUrl))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            productModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productModel.description),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ " + productModel.price.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        // homeBlocBloc.add(HomeProductWishListButtonClickedEvent(
                        //     clickedProduct: productModel));
                        // homeBlocBloc.add(HomeWishListButtonNavigateEvent());
                      },
                      child: Icon(Icons.favorite_border)),
                  GestureDetector(
                      onTap: () {
                        cartBlocBloc.add(CartRemoveFromCartEvent(
                            productModel: productModel));
                      },
                      child: Icon(Icons.remove))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
