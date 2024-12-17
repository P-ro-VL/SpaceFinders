import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedImageWidget extends StatelessWidget {
  SelectedImageWidget({required this.path, required this.name, this.onDelete});

  final Uint8List path;
  final String name;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: name.endsWith('.pdf')
                ? const Icon(
                    Icons.picture_as_pdf_outlined,
                    size: 32,
                    color: Colors.red,
                  )
                : Image.memory(path),
          ),
          Text(name.substring(0, min(100, name.length)),
              style: const TextStyle(fontSize: 14)),
          GestureDetector(
            onTap: () {
              onDelete?.call();
            },
            child: const Icon(
              Icons.delete_outline,
              color: Colors.black26,
              size: 24,
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 8, horizontal: 16),
    );
  }
}
