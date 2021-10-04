import 'package:ahulang/api/auth_service.dart';
import 'package:ahulang/api/location_service.dart';
import 'package:ahulang/api/realtime_database.dart';
import 'package:ahulang/component/address_card.dart';
import 'package:ahulang/model/absen.dart';
import 'package:ahulang/model/route_manager.dart';
import 'package:ahulang/model/user_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PulangScreen extends StatefulWidget {
  @override
  _PulangScreenState createState() => _PulangScreenState();
}

class _PulangScreenState extends State<PulangScreen> {
  RealTimeDatabase realTimeDatabase = RealTimeDatabase();
  LocationService locationService = LocationService();
  GoogleMapController? _controller;
  double latitude = 0;
  double longitude = 0;
  var tgl = DateFormat("EEEE, d MMMM yyyy").format(DateTime.now()).toString();
  var jam = DateFormat("HH.mm").format(DateTime.now()).toString();
  String _address = "";
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Null> _getUserDetail() async {
    var current = _auth.currentUser;
    _auth.authStateChanges().listen((event) {
      user = event;
    });
    if (current != null) {
      setState(() {
        user = current;
      });
    } else {
      await AuthService.signOut();
      Navigator.pushNamed(context, RouteManager.LoginPage);
    }
  }

  void _getPlace(UserLocation position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude!, position.longitude!);

    Placemark placeMark = placemarks[0];
    String? street = placeMark.street;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String address =
        "${street}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);

    setState(() {
      _address = address; // update _address
    });
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  final Set<Marker> _markers = {};

  @override
  void initState() {
    locationService.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude!;
        longitude = userLocation.longitude!;
        _markers.add(
          Marker(
              markerId: MarkerId("Marker"),
              draggable: false,
              position: LatLng(latitude, longitude),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(title: "You are here")),
        );
        moveToNow();
        _getPlace(userLocation);
        _getUserDetail();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 17.0,
            ),
            markers: _markers,
            onMapCreated: mapCreated,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75, bottom: 50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Card(
                color: Theme.of(context).primaryColor,
                elevation: 5,
                child: Container(
                  height: 50,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      realTimeDatabase.insertData(
                          Absen(tgl, jam, _address, 'Home'), user!);
                      Navigator.pushNamed(context, RouteManager.HomePage);
                    },
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 100.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Card(
              color: Colors.white70,
              elevation: 5,
              child: InkWell(
                splashColor: Colors.black87,
                onTap: moveToNow,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(color: Colors.white70),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: AddressCard(),
        ),
      ]),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveToNow() {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 17.0)));
  }
}
