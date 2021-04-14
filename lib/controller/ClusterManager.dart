import 'package:denguego/boundary/HomeScreen.dart';
import 'package:denguego/entity/ClusterLocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:geocoding/geocoding.dart';

class ClusterManager {
  static bool loaded = false;
  static WebScraper webScraper;
  static List<String> keys = [];
  static Map<String, ClusterLocation> LocationList = {};
  static List<String> nearByClusters = [];

  static Future<List<String>> getAllLocations() async {
    List<String> updates;
    List<String> individualCluster = [];

    webScraper = WebScraper('https://www.nea.gov.sg');

    if (await webScraper.loadWebPage('/dengue-zika/dengue/dengue-clusters')) {
      List<Map<String, dynamic>> results =
          webScraper.getElement('table', ['title']);
      List<Map<String, dynamic>> clusterNames =
          webScraper.getElement('.rte a:not([class^=btn])', ['title']);
      int clusterCases;
      String locName;
      for (var i = 2; i < results.length; i++) {
        clusterCases = 0;
        updates = [];
        String clusterName = clusterNames[i - 2]['title'];
        individualCluster = results[i]['title'].split("    ");

        for (var j = 59; j < individualCluster.length; j += 42) {
          locName = individualCluster[j]
              .substring(0, individualCluster[j].length - 1);

          clusterCases += int.parse(individualCluster[j + 11]);

          ClusterManager.LocationList[locName] = ClusterLocation(
            location: locName,
            cases: int.parse(individualCluster[j + 11]),
            cluster: clusterName,
            zone: '',
          );

          await getLatLong(ClusterManager.LocationList[locName]);
          await calculateDistance(ClusterManager.LocationList[locName], 3);

          updates.add(locName);
        }

        for (String loc in updates) {
          ClusterManager.LocationList[loc].clusterCases = clusterCases;
          ClusterManager.LocationList[loc].zone =
              clusterCases > 10 ? "High Risk" : "Medium Risk";
        }
      }
    }
//WebScraping for Under surveillance NEA website
    if (await webScraper.loadWebPage(
        '/dengue-zika/dengue/dengue-clusters-under-surveillance')) {
      List<Map<String, dynamic>> results =
          webScraper.getElement('table', ['title']);
      String locName;

      individualCluster = results[0]['title'].split("              ");

      for (var j = 14; j < individualCluster.length; j += 10) {
        locName =
            individualCluster[j].substring(0, individualCluster[j].length - 1);

        ClusterManager.LocationList[locName] = ClusterLocation(
          location: locName,
          cases: int.parse(individualCluster[j + 2]),
          cluster: 'Not applicable',
          zone: 'Under surveillance',
        );

        await getLatLong(ClusterManager.LocationList[locName]);
      }
    }

    keys = ClusterManager.LocationList.keys.toList();
    keys.sort();
    return keys;
  }

//Finding Longitude and latitude and saving in cluster coordinates attribute
  static getLatLong(ClusterLocation cluster) async {
    try {
      cluster.coordinates =
          await locationFromAddress(cluster.location + " Singapore");
    } catch (e) {
      print(e);
    }
  }

//Finding nearby clusters by calculating distance based on minDistance
  static calculateDistance(ClusterLocation cluster, int minDistance) async {
    var currentLocation = await HomeScreen.locationTracker.getLocation();

    var _distanceInMeters = await Geolocator.distanceBetween(
      cluster.coordinates[0].latitude,
      cluster.coordinates[0].longitude,
      currentLocation.latitude,
      currentLocation.longitude,
    );

    if (_distanceInMeters / 1000 < minDistance) {
      if (!nearByClusters.contains(cluster.cluster))
        nearByClusters.add(cluster.cluster);
    }
  }
}
