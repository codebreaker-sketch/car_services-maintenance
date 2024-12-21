// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class LocationsPage extends StatefulWidget {
//   const LocationsPage({Key? key}) : super(key: key);

//   @override
//   _LocationsPageState createState() => _LocationsPageState();
// }

// class _LocationsPageState extends State<LocationsPage> {
//   late MapController _mapController;
//   double _currentZoom = 13.0;

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
//       _mapController.move(_mapController.center, _currentZoom);
//     });
//   }

//   void _zoomOut() {
//     setState(() {
//       _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
//       _mapController.move(_mapController.center, _currentZoom);
//     });
//   }

//   Future<void> _searchLocation(BuildContext context) async {
//     String? location = await showDialog(
//       context: context,
//       builder: (context) {
//         String query = '';
//         return AlertDialog(
//           title: const Text('Search Location'),
//           content: TextField(
//             onChanged: (value) => query = value,
//             decoration: const InputDecoration(hintText: 'Enter location name'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(query),
//               child: const Text('Search'),
//             ),
//           ],
//         );
//       },
//     );

//     if (location != null && location.isNotEmpty) {
//       // Mock coordinates for simplicity (replace with real geocoding API later)
//       final LatLng mockCoords = LatLng(40.7128, -74.0060); // Example: New York
//       setState(() {
//         _mapController.move(mockCoords, _currentZoom);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Locations"),
//         backgroundColor: Colors.blueAccent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => _searchLocation(context),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               center: LatLng(37.7749, -122.4194), // Coordinates for San Francisco
//               zoom: _currentZoom,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c'],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   mini: true,
//                   onPressed: _zoomIn,
//                   child: const Icon(Icons.add),
//                 ),
//                 const SizedBox(height: 10),
//                 FloatingActionButton(
//                   mini: true,
//                   onPressed: _zoomOut,
//                   child: const Icon(Icons.remove),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';

// class LocationsPage extends StatefulWidget {
//   const LocationsPage({Key? key}) : super(key: key);

//   @override
//   _LocationsPageState createState() => _LocationsPageState();
// }

// class _LocationsPageState extends State<LocationsPage> {
//   late MapController _mapController;
//   double _currentZoom = 13.0;

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
//       _mapController.move(_mapController.center, _currentZoom);
//     });
//   }

//   void _zoomOut() {
//     setState(() {
//       _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
//       _mapController.move(_mapController.center, _currentZoom);
//     });
//   }

//   Future<void> _searchLocation(BuildContext context) async {
//     String? location = await showDialog(
//       context: context,
//       builder: (context) {
//         String query = '';
//         return AlertDialog(
//           title: const Text('Search Location'),
//           content: TextField(
//             onChanged: (value) => query = value,
//             decoration: const InputDecoration(hintText: 'Enter city name in Pakistan'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(query),
//               child: const Text('Search'),
//             ),
//           ],
//         );
//       },
//     );

//     if (location != null && location.isNotEmpty) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//             'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(location)}&format=json&addressdetails=1&countrycodes=pk',
//           ),
//         );

//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           if (data != null && data.isNotEmpty) {
//             final coords = data[0];
//             final LatLng locationCoords = LatLng(
//               double.parse(coords['lat']),
//               double.parse(coords['lon']),
//             );
//             setState(() {
//               _mapController.move(locationCoords, _currentZoom);
//             });
//           } else {
//             _showErrorDialog(context, "City not found in Pakistan.");
//           }
//         } else {
//           _showErrorDialog(context, "Error fetching location data.");
//         }
//       } catch (e) {
//         _showErrorDialog(context, "An error occurred: $e");
//       }
//     }
//   }

//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Locations"),
//         backgroundColor: Colors.blueAccent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => _searchLocation(context),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               center: LatLng(30.3753, 69.3451), // Default to Pakistan
//               zoom: _currentZoom,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c'],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   mini: true,
//                   onPressed: _zoomIn,
//                   child: const Icon(Icons.add),
//                 ),
//                 const SizedBox(height: 10),
//                 FloatingActionButton(
//                   mini: true,
//                   onPressed: _zoomOut,
//                   child: const Icon(Icons.remove),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// WORKING WALA CODE HAI BHAI JAN

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';

// class LocationsPage extends StatefulWidget {
//   const LocationsPage({Key? key}) : super(key: key);

//   @override
//   _LocationsPageState createState() => _LocationsPageState();
// }

// class _LocationsPageState extends State<LocationsPage> {
//   late MapController _mapController;
//   double _currentZoom = 13.0;
//   LatLng _currentCenter = LatLng(30.3753, 69.3451); // Default center: Pakistan

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
//       _mapController.move(_currentCenter, _currentZoom);
//     });
//   }

//   void _zoomOut() {
//     setState(() {
//       _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
//       _mapController.move(_currentCenter, _currentZoom);
//     });
//   }

//   Future<void> _searchLocation(BuildContext context) async {
//     String? location = await showDialog(
//       context: context,
//       builder: (context) {
//         String query = '';
//         return AlertDialog(
//           title: const Text('Search Location'),
//           content: TextField(
//             onChanged: (value) => query = value,
//             decoration: const InputDecoration(hintText: 'Enter city name in Pakistan'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(query),
//               child: const Text('Search'),
//             ),
//           ],
//         );
//       },
//     );

//     if (location != null && location.isNotEmpty) {
//       try {
//         final response = await http.get(
//           Uri.parse(
//             'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(location)}&format=json&addressdetails=1&countrycodes=pk',
//           ),
//         );

//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           if (data != null && data.isNotEmpty) {
//             final coords = data[0];
//             final LatLng locationCoords = LatLng(double.parse(coords['lat']), double.parse(coords['lon']));
//             setState(() {
//               _currentCenter = locationCoords;
//               _mapController.move(_currentCenter, _currentZoom);
//             });
//           } else {
//             _showErrorDialog(context, "City not found in Pakistan.");
//           }
//         } else {
//           _showErrorDialog(context, "Error fetching location data.");
//         }
//       } catch (e) {
//         _showErrorDialog(context, "An error occurred: $e");
//       }
//     }
//   }

//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Locations"),
//         backgroundColor: Colors.blueAccent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => _searchLocation(context),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               center: _currentCenter,
//               zoom: _currentZoom,
//               maxZoom: 18.0,
//               minZoom: 1.0,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c'],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   mini: true,
//                   onPressed: _zoomIn,
//                   child: const Icon(Icons.add),
//                 ),
//                 const SizedBox(height: 10),
//                 FloatingActionButton(
//                   mini: true,
//                   onPressed: _zoomOut,
//                   child: const Icon(Icons.remove),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late MapController _mapController;
  double _currentZoom = 13.0;
  LatLng _currentCenter = LatLng(30.3753, 69.3451); // Default center: Pakistan

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
      _mapController.move(_currentCenter, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
      _mapController.move(_currentCenter, _currentZoom);
    });
  }

  Future<void> _searchLocation(BuildContext context) async {
    String? location = await showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return AlertDialog(
          title: const Text('Search Location'),
          content: TextField(
            onChanged: (value) => query = value,
            decoration: const InputDecoration(hintText: 'Enter city name in Pakistan'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(query),
              child: const Text('Search'),
            ),
          ],
        );
      },
    );

    if (location != null && location.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse(
            'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(location)}&format=json&addressdetails=1&countrycodes=pk',
          ),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data != null && data.isNotEmpty) {
            final coords = data[0];
            final LatLng locationCoords = LatLng(double.parse(coords['lat']), double.parse(coords['lon']));
            setState(() {
              _currentCenter = locationCoords;
              _mapController.move(_currentCenter, _currentZoom);
            });
          } else {
            _showErrorDialog(context, "City not found in Pakistan.");
          }
        } else {
          _showErrorDialog(context, "Error fetching location data.");
        }
      } catch (e) {
        _showErrorDialog(context, "An error occurred: $e");
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _searchLocation(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentCenter,
              zoom: _currentZoom,
              maxZoom: 18.0,
              minZoom: 1.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
