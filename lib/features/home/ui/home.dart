import 'package:bloc2/features/home/bloc/home_bloc_bloc.dart';
import 'package:bloc2/features/wishlist/ui/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/ui/cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    homeBlocBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBlocBloc homeBlocBloc = HomeBlocBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      bloc: homeBlocBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ));
        } else if (state is HomeNavigateToWishistPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => wishlist(),
              ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text("Saurav Shop Store"),
                actions: [
                  GestureDetector(
                      onTap: () {
                        homeBlocBloc.add(HomeWishListButtonNavigateEvent());
                      },
                      child: Icon(Icons.favorite_border)),
                  GestureDetector(
                      onTap: () {
                        homeBlocBloc.add(HomeCartButtonNavigateEvent());
                      },
                      child: Icon(Icons.shopping_bag_outlined))
                ],
              ),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
