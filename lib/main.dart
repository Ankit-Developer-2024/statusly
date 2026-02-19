import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statusly/core/localization/localization.dart';
import 'package:statusly/core/routing/app_pages.dart';
import 'package:statusly/core/routing/app_routes.dart';
import 'package:statusly/core/styles/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await openHive();
  runApp(const MyApp());
}

openHive()async{
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox("statusly");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Statusly',
      translations: AppLocalization(),
      locale: AppLocalization.englishLocale,
      fallbackLocale: AppLocalization.fallbackLocale,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.getPages,
    );
  }
}