import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class LocalmapPage extends StatefulWidget {
  const LocalmapPage({Key? key}) : super(key: key);

  @override
  _LocalmapPageState createState() => _LocalmapPageState();
}

class _LocalmapPageState extends State<LocalmapPage> {
  late List<Data> _data;
  late List<Marker> _mark;
  final Geolocator geolocator = Geolocator();
  late Position _currentPosition = new Position(longitude: 53.35014, latitude: -6.24529, timestamp: new DateTime(2021,1,1,1), accuracy: 0.00, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0);
  

  @override
  void initState() {
    _data = <Data>[Data(53.35014, -6.24529, 15), Data(53.35023, -6.24034, 13)];
    _mark = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point:LatLng(_data[0].lat, _data[0].lng),
       
        builder: (ctx) => Container(
          child: FlutterLogo(),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_data[1].lat, _data[1].lng),
        builder: (ctx) => Container(
          child: FlutterLogo(),
        ),
      ),
    ];
   
    super.initState();
   
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

 
 void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    print(position);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(_data[0].lat,_data[0].lng),
          zoom: _data[0].zoom,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(markers: _mark),
        ],
      ),
    );
  }
}

class Data {
  final double lat;
  final double lng;
  final double zoom;
  const Data(this.lat, this.lng, this.zoom);
}

