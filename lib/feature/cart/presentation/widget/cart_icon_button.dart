import 'package:flutique/config/theme/app_colors.dart';
import 'package:flutique/feature/cart/presentation/bloc/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      final count = (state is CartLoaded) ? state.totalItems : 0;

      return ElevatedButton(
        onPressed: () {
          GoRouter.of(context).push('/cart');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        child: Text('Add to cart'),
      );
    });
  }
}
