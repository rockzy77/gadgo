import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget{
  const HomeAppBar({required this.advancedDrawerController});
  final AdvancedDrawerController advancedDrawerController;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
            backgroundColor: Colors.white,
            elevation: 0,

            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      color: Colors.black,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.black,),
                onPressed: (){},
              ),
            ],
          );
  }

   void _handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}