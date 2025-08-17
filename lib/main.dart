import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/Providers/Data/fetch_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FetchProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Build Context is calling");
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Consumer<FetchProvider>(
            builder: (ctx, provider, __) {
              print("Consumer is calling");
              return Text(
                '${provider.getCount()}',
                style: TextStyle(fontSize: 30),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<FetchProvider>().increamentCount();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
