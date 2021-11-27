import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotelier/widgets/ButtonWidget.dart';

class GetLocationScreen extends StatefulWidget {
  static const routeName = '/GetLocationScreen';
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER
  String locationString = "";
  bool isGettingLocation = false;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );// , MAP OF MARKS
  Completer<GoogleMapController> _controller = Completer();
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyCeaBTry2YnTPFGYdD6IJqtT4HjFtOr8As");
  late Position positions;
  late LatLng selectedPosition ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0 ,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: GoogleMap(
                mapType: MapType.normal,
                // myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                // myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (latLang){
                  print(latLang);
                  _addMarker(latLang);
                },
                markers: Set<Marker>.of(markers.values),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

          ),
          Positioned(
            top: 40,
            left: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(16),
                constraints: BoxConstraints(minHeight:MediaQuery.of(context).size.width/10 ),
                width: MediaQuery.of(context).size.width/2,
                color: Color(0x44000000),
                child: Row(
                  children: <Widget>[

                    Expanded(
                      flex: 2,
                      child: Container(
                        constraints: BoxConstraints(minHeight:MediaQuery.of(context).size.width/10 ),
                        width: MediaQuery.of(context).size.width/2,
                        child:isGettingLocation ? Center(child:CircularProgressIndicator()): Text(locationString),
                      ),

                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Align(alignment: Alignment.topRight,
                          child: IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () async{
                            var p = await PlacesAutocomplete.show(
                              context: context, apiKey: "AIzaSyCeaBTry2YnTPFGYdD6IJqtT4HjFtOr8As" ,
                              mode: Mode.overlay,
                            );
                           print(p);
                          }),),),
                    ),
                  ],
                ),
              ),
            ),

          ),

          Positioned(
            top: size.height - 80,
            left: 16,
            child: InkWell(
              onTap: (){ Navigator.of(context).pop(selectedPosition);},
              child: ButtonChildWidget("اختر المكان", Color(0xFFF7BB85) , 24 , 180),
            )

          ),


        ],
      ),
    );
  }


  void getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print("permission");
    print("permission================================================>");
    print(permission);
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best );

    print("position");
    print("position================================================>");
    print(position);

    print("position");
    print("position================================================>");

    _addMarker(LatLng(position.latitude, position.longitude));
    _redirctCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: new LatLng(position.latitude, position.longitude),
        tilt: 59.440717697143555,
        zoom: 15));
    setState(() {
      positions = position;
      // this.isGettingLocation = true;
    });
  }

  Future<void> _redirctCameraPosition(CameraPosition cameraPosition ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void _addMarker(LatLng latLang) async {
    var markerIdVal = "50";
    setState(() {
      this.selectedPosition = latLang ;
    });
    final MarkerId markerId = MarkerId(markerIdVal);
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: latLang,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );
    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
    setState(() {
      this.isGettingLocation = true ;
    });
    var address = await Geocoder.local.findAddressesFromCoordinates(new Coordinates(latLang.latitude, latLang.longitude)) ;

    setState(() {
      this.locationString = address.first.addressLine ;
      this.isGettingLocation = false ;
    });
  }
}
