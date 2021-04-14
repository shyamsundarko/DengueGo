import 'package:denguego/controller/ClusterManager.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart' as lp;
import 'package:permission_handler/permission_handler.dart';

class SystemManager {
  static UserAccountManager userMgr = UserAccountManager();

  static Future<List<String>> loadInformation(BuildContext context) async {
    bool locationService = true;

    do {
      locationService = true;
      ServiceStatus serviceStatus = await PermissionHandler()
          .checkServiceStatus(PermissionGroup.location);
      if (serviceStatus != ServiceStatus.enabled) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor: Color(0xffe25757),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          icon: Icon(
            Icons.location_city_outlined,
            size: 35.0,
            color: Colors.black,
          ),
          leftBarIndicatorColor: Colors.black,
          messageText: Text("Please enable location services for this feature.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Montserrat')),
          duration: Duration(seconds: 7),
        )..show(context);
        await Future.delayed(Duration(seconds: 15));
        //print('i am here alr');
      } else {
        locationService = false;
        //print('i am here too tooo');
      }
    } while (locationService);
    do {
      locationService = true;
      lp.PermissionStatus permission =
          await lp.LocationPermissions().checkPermissionStatus();
      if (permission == lp.PermissionStatus.denied) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          backgroundColor: Color(0xffe25757),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          icon: Icon(
            Icons.location_city_outlined,
            size: 35.0,
            color: Colors.black,
          ),
          leftBarIndicatorColor: Colors.black,
          messageText: Text("Please grant location services for this feature.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Montserrat')),
          duration: Duration(seconds: 7),
        )..show(context);

        await Future.delayed(Duration(seconds: 15));
        // print('i am here now');
      } else {
        locationService = false;

        //print('i am here too');
      }
    } while (locationService);
    print('done');
    List<String> clusterInformation = await ClusterManager.getAllLocations();
    print('done al loc');
    await UserAccountManager.populateUser();
    return clusterInformation;
  }
}
