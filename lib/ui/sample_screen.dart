import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sample")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              imageWidget,
              listWidget,
            ],
          ),
        ),
      ),
    );
  }
}

var imageWidget = const Image(
  image: NetworkImage(
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
);

var listWidget = ListView(
  shrinkWrap: true,
  children: const <Widget>[
    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
    ),
    ListTile(
      leading: Icon(Icons.photo_album),
      title: Text('Album'),
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Phone'),
    ),
  ],
);
