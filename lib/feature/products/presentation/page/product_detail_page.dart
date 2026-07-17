import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutique/config/theme/app_colors.dart';
import 'package:flutique/feature/products/domain/entities/product.dart';
import 'package:flutique/feature/products/presentation/bloc/product_detail_bloc/product_detail_cubit.dart';
import 'package:flutique/feature/products/presentation/widget/rating_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.turkey),
              );
            } else if (state is ProductDetailLoaded) {
              return _buildProduct(context, state.product);
            } else if (state is ProductDetailError) {
              return Center(child: Text('Error'));
            } else {
              return Center(child: Text('Error'));
            }
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined)),
          SizedBox(width: 10,),
        ],
    );
  }

  Widget _buildProduct(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Product Image
        CachedNetworkImage(
          imageUrl: product.images!.first,
          width: MediaQuery.of(context).size.width,
          placeholder:
              (BuildContext context, String url) => Center(
                child: const CircularProgressIndicator(color: AppColors.turkey),
              ),
          errorWidget:
              (BuildContext context, String url, Object error) =>
                  const Icon(Icons.no_photography_outlined, size: 120),
        ),
        //Info Product
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingInfo(rating: product.rating.toStringAsFixed(2)),
                  Text(
                    "\$${product.price.toStringAsFixed(2)} USD",
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                product.brand != null ? "By: ${product.brand}" : '',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //CTA – Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                      ),
                      child: Text('Buy Now'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Add to cart'),
                    ),
                  ),
                ],
              ),

              //Description and reviews etc
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(
                  color: AppColors.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(product.description, style: TextStyle(fontSize: 14)),
              SizedBox(height: 15),
              //Tags
              Text(
                'Tags',
                style: TextStyle(
                  color: AppColors.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              _buildTags(context, product),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _buildTags(BuildContext context, Product product) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: product.tags?.length,
        itemBuilder: (context, index) {
          final tag = product.tags?[index] ?? '';
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
              ),
              onPressed: () {},
              child: Text(tag),
            ),
          );
        },
      ),
    );
  }
}
