import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_cart/app/view/home/bloc/home_bloc.dart';
import 'package:universal_cart/app/view/home/home.dart';
import 'package:universal_cart/app/view/qr_scanner/bloc/barcode_scanner_bloc.dart';
import 'package:universal_cart/cart_repository.dart';

void main() {
  runApp(MyApp(shoppingRepository: ShoppingRepository()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.shoppingRepository});

  final ShoppingRepository shoppingRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(
            shoppingRepository: shoppingRepository,
          )..add(CartStarted()),
        ),
        BlocProvider(
          create: (_) => BarcodeScannerBloc(
            shoppingRepository: ShoppingRepository(),
          )..add(ScannerStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Cart App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
