import 'package:flutique/feature/products/presentation/bloc/product_bloc.dart';
import 'package:flutique/feature/products/presentation/page/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'injection_container.dart';

void main() async {
  await dotenv.load();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => sl<ProductBloc>(),
        child: ProductsPage(),
      ),
    );
  }
}


