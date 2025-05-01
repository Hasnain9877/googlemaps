import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/map_controller.dart';

class Home extends StatelessWidget {
  late GoogleMapController _mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
   Home({super.key});

 final GoogleMapsController mapController = Get.put(GoogleMapsController());

   RxInt counter = 0.obs;

   void onMapCreated(GoogleMapController controller){
   //  _mapController = controller;

     mapController.mapController.complete(controller);
   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Maps Demo'),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: [
           Obx(()=> GoogleMap(
               onMapCreated: onMapCreated,

               initialCameraPosition: CameraPosition(
                   zoom: 10.0,
                   target: mapController.currentPosition.value),
             markers: {
                 Marker(markerId: MarkerId('search location'),
                 position: mapController.currentPosition.value
                 )
             },


           ),),
            Positioned(child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4)
                ],
              ),
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    controller: mapController.searchController,
                    decoration: InputDecoration(
                      hintText: "Enter location",
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(onPressed: (){
                    mapController.searchLocation();

                  }, icon: Icon(Icons.search))
                ],
              ),

            ))
            
          ],
        )

      ),
    );
  }
}
