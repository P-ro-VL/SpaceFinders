import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LeadDetailPropertyW extends StatelessWidget {
  const LeadDetailPropertyW({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xff2B78A3)),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1C2B38),
                  height: 0,
                ),
              ),
              const SizedBox(height: 10),
              Text(value,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xff495560))),
            ],
          )
        ],
      ),
    ).paddingOnly(bottom: 12);
  }
}
