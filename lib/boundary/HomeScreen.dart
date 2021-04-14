import 'dart:typed_data';
import 'package:denguego/controller/SavedManager.dart';
import 'package:denguego/widgets/PopUpLocationCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:denguego/controller/ClusterManager.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:denguego/entity/ClusterLocation.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';

class HomeScreen extends StatefulWidget {
  static Location locationTracker = Location();
  static List<Marker> allMarkers = [];
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool locationSelected = false;
  bool currentSelected = false;
  String place = "";
  Circle circle;
  GoogleMapController _controller;
  static final CameraPosition initialLocation =
      CameraPosition(target: LatLng(1.3521, 103.8198), zoom: 10.5);
  Map<String, ClusterLocation> clusterDetails = ClusterManager.LocationList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              locationSelected
                  ? PopUpLocationCard(
                      location: clusterDetails[place].location,
                      cases: clusterDetails[place].cases,
                      cluster: clusterDetails[place].cluster,
                      clusterCases: clusterDetails[place].clusterCases,
                      zone: clusterDetails[place].zone,
                      saved: SavedManager.isSaved(clusterDetails[place]),
                      savedFunc: () {
                        setState(() {
                          SavedManager.editSaved(clusterDetails[place]);
                          locationSelected = true;
                        });
                      },
                    )
                  : Text(''),
            ],
          ),
          _buildSearch(ClusterManager.keys),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 90, 8, 8),
              child: RawMaterialButton(
                elevation: 10,
                onPressed: () {
                  if (!currentSelected) {
                    getCurrentLocation();
                  } else {
                    _controller.animateCamera(
                        CameraUpdate.newCameraPosition(initialLocation));
                  }
                  setState(() {
                    currentSelected = !currentSelected;
                  });
                },
                child: currentSelected
                    ? Icon(
                        Icons.gps_not_fixed,
                        size: 27,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.gps_fixed,
                        size: 27,
                        color: Colors.white,
                      ),
                shape: CircleBorder(),
                fillColor: Color(0xff5B92C8),
                padding: EdgeInsets.all(15.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          markers: Set.from(HomeScreen.allMarkers),
          circles: Set.of((circle != null) ? [circle] : []),
          onTap: (LatLng) {
            setState(() {
              locationSelected = false;
              _controller.animateCamera(
                  CameraUpdate.newCameraPosition(initialLocation));
            });
          },
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          }),
    );
  }

  Widget _buildSearch(List<String> clusters) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 25, 15, 15),
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.white,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Color(0x802196F3),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: customSearchableDropDown(
                showClearButton: true,
                hideSearch: false,
                menuMode: false,
                dropDownMenuItems: clusters?.map((item) {
                      return item;
                    })?.toList() ??
                    [],
                items: clusters,
                label: 'Search for clusters',
                //decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.search),
                ),
                onChanged: (value) {
                  if (value != null) {
                    place = value;
                    gotoClusterLocation(clusterDetails[place]);
                    setState(() {
                      locationSelected = true;
                    });
                  } else {
                    _controller.animateCamera(
                        CameraUpdate.newCameraPosition(initialLocation));
                    setState(() {
                      locationSelected = false;
                    });
                  }
                }),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    addMarkers(ClusterManager.LocationList.keys.toList());
    super.initState();
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/arrow.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      HomeScreen.allMarkers.add(Marker(
          markerId: MarkerId("home"),
          position: latLng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData)));
      circle = Circle(
          circleId: CircleId("arrow"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latLng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await HomeScreen.locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude),
        zoom: 16,
        tilt: 0,
        bearing: 0.0,
      )));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  Future<void> gotoClusterLocation(ClusterLocation cluster) async {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(cluster.coordinates[0].latitude,
              cluster.coordinates[0].longitude),
          zoom: 16,
          tilt: 0,
          bearing: 0.0,
        ),
      ),
    );
  }

  void addMarkers(List<String> clusters) async {
    for (int i = 0; i < clusters.length; i++) {
      String clusterloc = clusters[i];
      ClusterLocation loc = ClusterManager.LocationList[clusterloc];
      HomeScreen.allMarkers.add(Marker(
        markerId: MarkerId(loc.location),
        draggable: false,
        zIndex: 2,
        consumeTapEvents: true,
        onTap: () {
          gotoClusterLocation(loc);
          setState(() {
            locationSelected = true;
            place = loc.location;
          });
        },
        flat: true,
        anchor: Offset(0.5, 0.5),
        position:
            LatLng(loc.coordinates[0].latitude, loc.coordinates[0].longitude),
        icon:
            ClusterManager.LocationList[clusterloc].zone == 'Under surveillance'
                ? BitmapDescriptor.defaultMarkerWithHue(130)
                : ClusterManager.LocationList[clusterloc].zone == 'Medium Risk'
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange)
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
      ));
    }
  }
}
