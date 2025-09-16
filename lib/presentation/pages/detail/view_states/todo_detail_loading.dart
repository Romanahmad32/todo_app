import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoDetailLoading extends StatelessWidget {
  const TodoDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer(
        child: Container(),
      ),
    );
  }
}
