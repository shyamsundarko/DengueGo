import 'package:flutter/material.dart';

class PopUpLocationCard extends StatelessWidget {
  final String location;
  final int cases;
  final String zone;
  final String cluster;
  final int clusterCases;
  final Function savedFunc;
  final bool saved;

  PopUpLocationCard({
    this.location,
    this.cases,
    this.zone,
    this.cluster,
    this.clusterCases,
    this.savedFunc,
    this.saved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: zone == "Under surveillance"
              ? Color(0xff97be61)
              : zone == "Medium Risk"
                  ? Color(0xffdec649)
                  : Color(0xffd26666),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      location.toUpperCase() +
                          "\nCases: " +
                          cases.toString() +
                          '\n' +
                          zone +
                          " Zone",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          height: 1.5),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  IconButton(
                    icon: saved
                        ? Icon(
                            Icons.bookmark,
                          )
                        : Icon(
                            Icons.bookmark_border,
                          ),
                    onPressed: savedFunc,
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              zone == "Under surveillance"
                  ? SizedBox(
                      height: 1,
                    )
                  : Text(
                      cluster +
                          " Cluster" +
                          "\n\nCases since start of cluster: " +
                          clusterCases.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
