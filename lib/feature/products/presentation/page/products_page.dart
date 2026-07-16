import 'package:flutique/feature/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products'), centerTitle: true),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CupertinoActivityIndicator());
          } else if (state is ProductDone) {
            return ListView.builder(
              itemCount: state.products!.length,
              itemBuilder: (context, index){
                return Text(state.products![index].title);
              },
            );
          }else if(state is ProductError){
            return Text('Error');

          }else{
            return Text('Error');
          }
        },
      ),
    );
  }
}
