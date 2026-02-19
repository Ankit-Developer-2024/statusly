import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statusly/core/component/widgets/primary_button.dart';
import 'package:statusly/core/utility/utils.dart';

class StoragePermissionDialogBox extends StatelessWidget {
  const StoragePermissionDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       title: Text("Storage Permission"),
       content: Text("This app requires access to your storage to save files and media. Please enable it in settings."),
       actions: [
         PrimaryButton(
           onPress: (){
             Navigator.pop(context);
           },
           title: getString("cancel"),
         ),
         PrimaryButton(
           onPress: (){
             openAppSettings();
           },
           title: getString("Go to Settings"),
         ),
       ],
    );
  }
}
