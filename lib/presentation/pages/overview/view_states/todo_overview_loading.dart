import 'package:flutter/material.dart';

class TodoOverviewLoading extends StatelessWidget {
  const TodoOverviewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
