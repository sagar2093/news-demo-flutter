import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Found!"),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
