import 'package:denguego/controller/SystemManager.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:denguego/entity/ClusterLocation.dart';

class SavedManager {
  static bool isSaved(ClusterLocation loc) {
    for (String savedLoc in UserAccountManager.userDetails.SavedLocations) {
      if (savedLoc == loc.location) {
        return true;
      }
    }
    return false;
  }

  static void removeSaved(ClusterLocation loc) {
    for (String savedLoc in UserAccountManager.userDetails.SavedLocations) {
      if (savedLoc == loc.location) {
        UserAccountManager.userDetails.SavedLocations.remove(savedLoc);
        return;
      }
    }
    return;
  }

  static void editSaved(ClusterLocation loc) async {
    if (isSaved(loc)) {
      removeSaved(loc);
    } else
      UserAccountManager.userDetails.SavedLocations.add(loc.location);

    await SystemManager.userMgr
        .updateSavedLocations(UserAccountManager.userDetails.name);
  }
}
