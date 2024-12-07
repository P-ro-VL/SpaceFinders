import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationSubItem {
  final Function()? onTap;
  final String? text;

  NavigationSubItem({
    this.onTap,
    this.text,
  });
}

class NavigationItem extends StatelessWidget {
  const NavigationItem(
      {super.key, required this.title, this.onTap, this.items});

  final String title;
  final Function()? onTap;
  final List<NavigationSubItem>? items;

  @override
  Widget build(BuildContext context) {
    return (items ?? []).isEmpty
        ? GestureDetector(
            onTap: () {
              onTap?.call();
            },
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : MenuAnchor(
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
            menuChildren: (items ?? [])
                .map((e) => MenuItemButton(
                      onPressed: e.onTap,
                      child: Text(
                        e.text ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList());
  }
}
