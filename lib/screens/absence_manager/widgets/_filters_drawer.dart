part of '../absence_manager.dart';

class _FiltersDrawer extends StatelessWidget {
  const _FiltersDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: FiltersModalSheet());
  }
}
