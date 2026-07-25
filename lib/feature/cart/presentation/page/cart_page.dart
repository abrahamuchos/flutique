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
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int cantItems = 0;
        if (state is CartLoaded) cantItems = state.totalItems;
        return Scaffold(
          appBar: _buildAppBar(context, cantItems),
          body: _buildBody(context, state),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, int items) {
    return AppBar(
      title: Text('Cart (${items.toString()} items)'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          context.goNamed('products');
        },
        icon: Icon(Icons.arrow_back_outlined),
      ),
    );
  }

  RenderObjectWidget _buildBody(BuildContext context, CartState state) {
    if (state is CartLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.primary));
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
                  final item = state.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: CartItemCard(
                      item: item,
                      onIncrement: () {
                        context.read<CartCubit>().updateQty(
                          item.productId,
                          item.qty + 1,
                        );
                      },
                      onDecrement: () {
                        context.read<CartCubit>().updateQty(
                          item.productId,
                          item.qty - 1,
                        );
                      },
                      onRemove: () {
                        context.read<CartCubit>().removeItem(item.productId);
                      },
                    ),
                  );
                },
              ),
            ),
            _buildTotal(context, state),
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildTotal(BuildContext context, CartLoaded state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3.3,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total ${state.totalItems.toString()} items',
                style: TextStyle(color: AppColors.dark, fontSize: 16),
              ),
              Text(
                '\$${state.totalPrice.toStringAsFixed(2)} USD',
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          //CTA - Checkout
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
