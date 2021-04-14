import 'package:denguego/controller/ClusterManager.dart';
import 'package:denguego/controller/UserAccountManager.dart';
import 'package:denguego/controller/SavedManager.dart';
import 'package:denguego/entity/ClusterLocation.dart';
import 'package:denguego/widgets/SavedCard.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  bool isBookmarked = false;

  List<Widget> BuildSavedCards() {
    List<SavedCard> savedCards = [];
    if (UserAccountManager.userDetails.SavedLocations.isEmpty) {
      return [
        SizedBox(
          height: 24,
        ),
        Text(
          'No Saved locations',
          style: TextStyle(
              color: Colors.grey, fontSize: 20, fontFamily: 'Montserrat'),
        ),
      ];
    }
    for (String locName in UserAccountManager.userDetails.SavedLocations) {
      ClusterLocation loc;
      try {
        loc = ClusterManager.LocationList[locName];
        if (loc == null) {
          throw ("Not in location error");
        }
      } catch (e) {
        loc = ClusterLocation(
            location: locName,
            cases: 0,
            zone: 'Under Surveillance',
            cluster: '');
      }
      savedCards.add(SavedCard(
        location: loc.location,
        cases: loc.cases,
        zone: loc.zone,
        isBookmarked: true,
        savedFunc: () {
          setState(() {
            SavedManager.editSaved(loc);
          });
        },
      ));
    }
    return savedCards;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
              Center(
                child: Image.asset(
                  'images/location.png',
                ),
              ),
            ] +
            BuildSavedCards(),
      ),
    );
  }
}
