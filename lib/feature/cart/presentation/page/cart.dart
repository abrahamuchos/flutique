import 'package:flutique/config/theme/app_colors.dart';
import 'package:flutique/feature/cart/presentation/bloc/cart_cubit.dart';
import 'package:flutique/feature/cart/presentation/widget/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.goNamed('products');
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(child: Text('Your cart is empty'));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          item: state.items[index],
                          onIncrement: () {},
                          onDecrement: () {},
                          onRemove: () {},
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
