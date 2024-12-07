import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeadCommon {
  static String generateLeadCode({
    required String rentalType,
    required String propertyType,
    required bool isDesired,
  }) {
    String code = '';

    if (rentalType == 'Dài hạn') {
      code += 'DH';
    } else {
      code += 'NH';
    }

    if (isDesired) {
      code += "MT";
    } else {
      code += "CT";
    }

    if (propertyType == 'Đất nền') {
      code += "DN";
    } else if (propertyType == 'Văn phòng') {
      code += "VP";
    } else if (propertyType == 'Nhà trọ') {
      code += "NT";
    } else if (propertyType == "Cửa hàng") {
      code += "CH";
    } else if (propertyType == "Chung cư") {
      code += "CC";
    }

    int randomNumber = Random().nextInt(9999) + 1;
    code += randomNumber.toString().padLeft(4, '0');

    return code;
  }
}

class SnackbarCommon {
  static void showErrorSnackbar({String? errorMessage}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      title: 'Lỗi',
      message: errorMessage ?? 'Có lỗi xảy ra, vui lòng thử lại sau',
    ));
  }
}

extension CurrencyFormat on num {
  String get currencyFormat {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(this);
  }
}

extension DateFormatExts on num {
  String get ddMMyyyyFormat {
    final formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(toInt()));
  }
}

extension DateFormat2Exts on DateTime {
  String get ddMMyyyyFormat {
    final formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }
}

class ChoiceItem {
  final String? code;
  final String? name;

  ChoiceItem({
    this.code,
    this.name,
  });
}
