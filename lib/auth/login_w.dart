import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/l10n/app_l18.dart';

class LoginW extends StatelessWidget {
  LoginW({super.key});

  final controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Ln.i?.homeIlogin ?? '',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const SizedBox(
            height: 20,
          ),
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: Ln.i?.homeIusername,
                ),
                onChanged: (value) {
                  controller.username.value = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: Ln.i?.homeIpassword,
                ),
                onChanged: (value) {
                  controller.password.value = value;
                },
              ),
            ],
          )),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              final result = await controller.fetchUser();
              if (result) {
                Get.back();
              }
            },
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff2B78A3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  Ln.i?.homeIlogin ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
