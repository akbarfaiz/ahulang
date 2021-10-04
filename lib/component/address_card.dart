import 'package:ahulang/api/location_service.dart';
import 'package:ahulang/model/user_location.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AddressCard extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<AddressCard> {
  var tgl = DateFormat("EEEE, d MMMM yyyy").format(DateTime.now()).toString();
  var jam = DateFormat("HH.mm").format(DateTime.now()).toString();
  String _address = "";
  LocationService locationService = LocationService();
  double latitude = 0;
  double longitude = 0;

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
  void initState() {
    locationService.locationStream.listen((userLocation) {
      setState(() {
        _getPlace(userLocation);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Date : " + tgl),
            SizedBox(
              height: 20,
            ),
            Text("Time : " + jam),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Location : "),
                Expanded(
                  flex: 6,
                  child: Text(_address),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
