import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoOverviewLoading extends StatelessWidget {
  const TodoOverviewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Shimmer(child: Container()));
  }
}
