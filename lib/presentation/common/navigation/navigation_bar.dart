import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/auth/login_w.dart';
import 'package:spacefinder/data/datasource/report_data_source.dart';
import 'package:spacefinder/presentation/common/navigation/navigation_item.dart';
import 'package:spacefinder/presentation/contract/contract_management_page.dart';
import 'package:spacefinder/presentation/home/home_page.dart';
import 'package:spacefinder/presentation/lead/create/create_lead_layout.dart';
import 'package:spacefinder/presentation/lead/history/lead_history_page.dart';
import 'package:spacefinder/presentation/listing/listing_page.dart';
import 'package:spacefinder/presentation/management/lead_management.dart';
import 'package:spacefinder/presentation/report/report_page.dart';
import 'package:spacefinder/presentation/request/request_management_page.dart';
import 'package:spacefinder/routes.dart';

import '../../../l10n/app_l18.dart';
import '../../report/powerbi_report_page.dart';

class WebNavigationBar extends StatelessWidget {
  WebNavigationBar({super.key});

  final authenController = Get.find<AuthenticationController>();

  final reportDataSource = ReportDataSourceImpl();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.white),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo,
            const SizedBox(width: 32),
            Wrap(
              spacing: 24,
              children: _buildNavigations,
            ),
            const SizedBox(
              width: 100,
            ),
            authenController.user.value != null
                ? _buildAvatar
                : _buildAuthenButton,
            const SizedBox(
              width: 44,
            ),
            authenController.user.value != null
                ? _buildPostNewsButton
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget get _buildPostNewsButton => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Routes.goTo(const CreateLeadLayout());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xff287098),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/app_icon.svg",
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(width: 20),
                Text(
                  Ln.i?.navIpostNews ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget get _buildLogo => GestureDetector(
        onTap: () {
          Routes.goTo(const HomePage());
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff287098)),
              child: SvgPicture.asset('assets/icons/app_icon.svg',
                  width: 24, height: 24, fit: BoxFit.scaleDown),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              Ln.i?.title ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )
          ],
        ),
      );

  List<Widget> get _buildNavigations {
    final authController = Get.find<AuthenticationController>();
    final user = authController.user.value;

    if (user == null || user.role == 'CUSTOMER') {
      return [
        NavigationItem(title: 'Về chúng tôi', onTap: () {}),
        NavigationItem(
          title: 'Tin đăng BĐS',
          items: [
            NavigationSubItem(
                text: 'Tin đăng cho thuê BĐS',
                onTap: () {
                  Routes.goTo(LeadListingPage(isDemand: false));
                }),
            NavigationSubItem(
                text: 'Tin đăng muốn thuê BĐS',
                onTap: () {
                  Routes.goTo(LeadListingPage(isDemand: true));
                }),
          ],
        ),
        NavigationItem(
          title: 'Cẩm nang BĐS',
          items: [
            NavigationSubItem(text: 'Wiki', onTap: () {}),
            NavigationSubItem(text: 'Tin tức', onTap: () {}),
            NavigationSubItem(text: 'Dự án', onTap: () {}),
            NavigationSubItem(text: 'Phân tích', onTap: () {}),
          ],
        ),
        NavigationItem(
          title: 'Liên hệ',
          onTap: () {},
        ),
      ];
    } else if (user.role == 'SALES') {
      return [
        NavigationItem(
          title: 'Tin đăng BĐS',
          items: [
            NavigationSubItem(
                text: 'Tin đăng cho thuê BĐS',
                onTap: () {
                  Routes.goTo(LeadListingPage(isDemand: false));
                }),
            NavigationSubItem(
                text: 'Tin đăng muốn thuê BĐS',
                onTap: () {
                  Routes.goTo(LeadListingPage(isDemand: true));
                }),
          ],
        ),
        NavigationItem(
          title: 'Quản lý tin đăng BĐS',
          items: [
            NavigationSubItem(
                text: 'Quản lý tin đăng cho thuê BĐS',
                onTap: () {
                  Routes.goTo(const HomePage());
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Routes.goTo(const LeadManagementPage(isDemand: false));
                  });
                }),
            NavigationSubItem(
                text: 'Quản lý tin đăng muốn thuê BĐS',
                onTap: () {
                  Routes.goTo(const HomePage());
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Routes.goTo(const LeadManagementPage(isDemand: true));
                  });
                }),
            NavigationSubItem(
                text: 'Quản lý yêu cầu sau duyệt',
                onTap: () {
                  Routes.goTo(const RequestManagementPage());
                }),
          ],
        ),
        NavigationItem(
            title: 'Quản lý hợp đồng',
            onTap: () {
              Routes.goTo(const ContractManagementPage());
            }),
      ];
    } else {
      return [
        NavigationItem(
            title: 'Dashboard',
            onTap: () {
              Routes.goTo(const PowerbiReportPage());
            }),
        NavigationItem(
          title: 'Quản lý tin đăng BĐS',
          items: [
            NavigationSubItem(
                text: 'Quản lý tin đăng cho thuê BĐS',
                onTap: () {
                  Routes.goTo(const HomePage());
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Routes.goTo(const LeadManagementPage(isDemand: false));
                  });
                }),
            NavigationSubItem(
                text: 'Quản lý tin đăng muốn thuê BĐS',
                onTap: () {
                  Routes.goTo(const HomePage());
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Routes.goTo(const LeadManagementPage(isDemand: true));
                  });
                }),
            NavigationSubItem(
                text: 'Quản lý yêu cầu sau duyệt',
                onTap: () {
                  Routes.goTo(const RequestManagementPage());
                }),
          ],
        ),
        NavigationItem(
            title: 'Quản lý hợp đồng',
            onTap: () {
              Routes.goTo(const ContractManagementPage());
            }),
        NavigationItem(
          title: 'Quản lý báo cáo',
          onTap: () {
            Routes.goTo(const ReportPage());
          },
        ),
      ];
    }
  }

  Widget get _buildAvatar => MenuAnchor(
          builder: (context, controller, parent) => GestureDetector(
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 20,
                        minRadius: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/images/avatar.jpg'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              authenController.user.value?.fullName ?? '',
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              switch (authenController.user.value?.role) {
                                'SALES' => 'Sales BĐS',
                                'CUSTOMER' => 'Khách hàng',
                                _ => 'Quản trị viên'
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          menuChildren: [
            if (Get.find<AuthenticationController>().user.value?.role !=
                'ADMIN')
              MenuItemButton(
                onPressed: () => Routes.goTo(LeadHistoryPage()),
                child: const Text(
                  'Lịch sử tin đăng',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            MenuItemButton(
              onPressed: () async {
                await Get.find<AuthenticationController>().logOut();
                Routes.goTo(HomePage());
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ]);

  Widget get _buildAuthenButton => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: Get.context!,
                builder: (_) => AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: LoginW()));
          },
          child: Row(
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 18,
              ),
              const SizedBox(
                width: 9,
              ),
              Text(Ln.i?.navIsignInSignUp ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))
            ],
          ),
        ),
      );
}
