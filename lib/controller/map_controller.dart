import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';



class GoogleMapsController extends GetxController {
  Completer<GoogleMapController> mapController = Completer();
  var searchController = TextEditingController();
  var currentPosition = LatLng(37.7749, -122.4194).obs;


  Future<void> searchLocation() async {
    String searchText = searchController.text;

    try {
      List<Location> locations = await locationFromAddress(searchText);
      if(locations.isNotEmpty){
        Location location =locations.first;
        currentPosition.value = LatLng(location.latitude, location.longitude);
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newLatLng(currentPosition.value));
      }else{
return null;
      }


    }catch(e){
      print('error$e');

    }

  }






}