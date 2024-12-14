import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/presentation/common/form_mixin.dart';

class LoginW extends StatelessWidget with FormMixin {
  LoginW({super.key});

  final controller = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 753,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset('assets/images/login.jpeg',
                    height: 500, fit: BoxFit.cover)),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: SizedBox(
                    width: 513,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('SpaceFinders',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff287098))),
                        const SizedBox(height: 12),
                        const Text('Ngàn căn nhà - Vạn lựa chọn',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        buildInput(
                            text: 'Tên đăng nhập',
                            onChanged: (value) {
                              controller.username.value = value;
                            }),
                        buildInput(
                            text: 'Mật khẩu',
                            obsecure: true,
                            onChanged: (value) {
                              controller.password.value = value;
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IntrinsicWidth(
                              child: CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Ghi nhớ tài khoản',
                                      style: TextStyle(fontSize: 16)),
                                  value: false,
                                  onChanged: (value) {}),
                            ),
                            const Text('Quên mật khẩu',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff287098))),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: 513,
                          child: GestureDetector(
                            onTap: () async {
                              final result = await controller.fetchUser();
                              if (!result) {
                                Get.showSnackbar(const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  title: 'Lỗi',
                                  message:
                                      'Tên đăng nhập hoặc mật khẩu không đúng',
                                  duration: Duration(seconds: 3),
                                ));
                              } else {
                                Get.back();
                              }
                            },
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xff287098),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text('Đăng nhập',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Không có tài khoản? ',
                                style: TextStyle(fontSize: 16)),
                            TextSpan(
                                text: 'Đăng ký ngay',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff287098),
                                    fontWeight: FontWeight.bold)),
                          ])),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
