import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spacefinder/presentation/home/home_page.dart';
import 'package:spacefinder/routes.dart';

import '../../../l10n/app_l18.dart';

class CreateLeadSuccess extends StatelessWidget {
  const CreateLeadSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.assignment_turned_in_rounded,
          size: 64,
          color: Colors.green[400],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          Ln.i?.postIcreateLeadSuccess ?? '',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          Ln.i?.postIcreateLeadSuccessDesc ?? '',
        ),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            Routes.goTo(HomePage());
          },
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[700]!)),
            child: Center(
              child: Text(
                Ln.i?.postIbackToHome ?? '',
                style: TextStyle(color: Colors.blue[700]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
