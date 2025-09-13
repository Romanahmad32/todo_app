import 'package:flutter/material.dart';

import '../../core/page_config.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.work_history,
    name: 'Overview',
    child: OverviewPage(),
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
