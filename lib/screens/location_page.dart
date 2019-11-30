import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyDdhGiukP3LWzl2HFIvUtoe6n2wAdSwSzU');

class _LocationState extends State<Location> {
  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.8206, 30.8025));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                onPressed: () async {
                  // show input autocomplete with selected mode
                  // then get the Prediction selected
                  Prediction p = await PlacesAutocomplete.show(
                      context: context, apiKey: 'AIzaSyDdhGiukP3LWzl2HFIvUtoe6n2wAdSwSzU');
                  displayPrediction(p);
                },
                child: Icon(Icons.search),
              )
          )
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          ListTile(
            title: new Text("Gyms"),
            leading: new Icon(FontAwesomeIcons.dumbbell),
          ),
          Divider(),
          ListTile(
            onTap: () {
              _goToFitnessFirst();
              Navigator.of(context).pop();
            },
            title: new Text("Fitness First"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToCelebrityFitness();
              Navigator.of(context).pop();
            },
            title: new Text("Celebrity Fitness"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToChampion();
              Navigator.of(context).pop();
            },
            title: new Text("House of Champion"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Future<void> _goToFitnessFirst() async {
    double lat = 3.118165;
    double long = 101.675389;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('fitnessfirst'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'Fitness First', snippet: 'Welcome to fitness first')),
      );
    });
  }

  Future<void> _goToCelebrityFitness() async {
    double lat = 3.071903;
    double long = 101.607348;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('celebrityfitness'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Celebrity Fitness', snippet: 'Welcome to celebrity fitness')),
      );
    });
  }

  Future<void> _goToChampion() async {
    double lat = 3.042820;
    double long = 101.599132;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('houseofchampion'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'House Of Champion', snippet: 'Welcome to house of champion')),
      );
    });
  }
}
