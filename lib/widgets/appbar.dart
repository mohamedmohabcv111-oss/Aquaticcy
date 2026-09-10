
import 'package:flutter/material.dart';


class AquaticcyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AquaticcyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: const Color(0xFF076735),
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      shape: const Border(
        bottom: BorderSide(color: Color(0xFF044824), width: 8),
      ),
      title: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: const [
            Icon(Icons.grid_view_outlined, size: 32),
            SizedBox(width: 12),
            Text(
              'AQUATICCY',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}



