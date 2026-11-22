import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';

class MainShellPage extends StatelessWidget {
 const MainShellPage({required this.child, this.selectedIndex = 0, super.key});
 final Widget child;
 final int selectedIndex;
 @override
 Widget build(BuildContext context) => Scaffold(body: child, bottomNavigationBar: AppBottomNav(selectedIndex: selectedIndex));
}
