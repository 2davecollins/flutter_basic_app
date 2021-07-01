import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocalmapPage extends StatefulWidget {
  const LocalmapPage({Key? key}) : super(key: key);

  @override
  _LocalmapPageState createState() => _LocalmapPageState();
}


class _LocalmapPageState extends State<LocalmapPage> {
  late List<Data> _data;
  late List<Marker> _mark;
  @override
  void initState() { 
     _data =  <Data>[
      Data(53.35014,-6.24529,15),
      Data(53.35023,-6.24034,13)
    ];
    _mark = <Marker> [
       Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_data[0].lat, _data[0].lng),
        builder: (ctx) =>
          Container(
          child: FlutterLogo(),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_data[1].lat, _data[1].lng),
        builder: (ctx) =>
          Container(
          child: FlutterLogo(),
        ),
      ),
    ];
          
    super.initState();    
  }

  @override
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(_data[0].lat, _data[0].lng),
          zoom: _data[0].zoom,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(
            markers: _mark
          ),
        ],
      ),
    );
  }
}

class Data {
  final double lat;
  final double lng;
  final double zoom;
  const Data( this.lat,  this.lng, this.zoom);
}
