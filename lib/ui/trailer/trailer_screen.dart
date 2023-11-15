import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/ui/resources/resources.dart';

class TrailerScreen extends StatelessWidget {
  const TrailerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Center(child: Text('movie trailer')),
    );
  }
}
