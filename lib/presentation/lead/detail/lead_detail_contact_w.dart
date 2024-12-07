import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacefinder/data/datasource/user_data_source.dart';
import 'package:spacefinder/data/repository/user_repository_impl.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/entity/user_entity.dart';
import 'package:spacefinder/domain/usecase/get_user_detail_use_case.dart';
import 'package:spacefinder/l10n/app_l18.dart';

class LeadDetailContactW extends StatefulWidget {
  LeadDetailContactW({super.key, required this.lead});

  final LeadEntity lead;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LeadDetailContactW> {
  final isLoading = true.obs;
  final getUserDetailUseCase =
      GetUserDetailUseCase(UserRepositoryImpl(UserDataSourceImpl()));
  final saleAgent = Rxn<UserEntity>();

  @override
  void initState() {
    getUserDetailUseCase.call(widget.lead.uploadedBy ?? -1).then((response) {
      saleAgent.value = response.right;
      isLoading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoading.value
          ? CircularProgressIndicator()
          : Container(
              width: 370,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 3),
                      blurRadius: 5,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Ln.i?.leadIcontact ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 196,
                        height: 196,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(switch (saleAgent.value?.role) {
                        // 'SALES' => 'Chuyên viên tư vấn BĐS',
                        // 'ADMIN' => 'Quản trị viên',
                        _ => 'Chuyên viên tư vấn BĐS',
                      }),
                      Text(saleAgent.value?.fullName ?? '--',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff287098),
                          )),
                      Container(
                        width: 310,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xff287098),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(saleAgent.value?.phone ?? '--',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
