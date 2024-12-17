import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:spacefinder/auth/authentication_c.dart';
import 'package:spacefinder/constants.dart';
import 'package:spacefinder/presentation/layout_frame.dart';
import 'package:spacefinder/presentation/layout_frame_c.dart';
import 'package:spacefinder/test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  usePathUrlStrategy();
  final client = await Supabase.initialize(
    debug: true,
    url: 'https://myngagsqdrzsopzcsejl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15bmdhZ3NxZHJ6c29wemNzZWpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA0Njg2MDUsImV4cCI6MjA0NjA0NDYwNX0.s_uJoZ5hyDDxl9z3NlvgezB1Yxa98kJzR6seC2f1LKM',
  );
  // print(client);
  // print(Supabase.instance.client);
  Get.put(AuthenticationController(), permanent: true);
  Get.find<AuthenticationController>().fetchUserFromStorage();

  Get.put(LayoutFrameController(), permanent: true);

  Constants.initAddresses();

  runApp(const Spacefinder());
}

class Spacefinder extends StatelessWidget {
  const Spacefinder({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spacefinders',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: LayoutFrame(),
    );
  }
}
