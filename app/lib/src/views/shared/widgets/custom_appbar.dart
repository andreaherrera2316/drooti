import 'package:app/src/views/design/palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var p = Palette();
    return AppBar(
      backgroundColor: p.bg,
      elevation: 0,
      iconTheme: IconThemeData(color: p.chromeSilver),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
