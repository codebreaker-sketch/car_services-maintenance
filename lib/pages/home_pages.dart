// import 'package:flutter/material.dart';
// import 'package:flutter_car_service/style/color.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'service_form.dart'; // Import ServiceForm page
// import 'package:flutter_car_service/data/articles_data.dart';
// import 'package:flutter_car_service/data/service.dart';
// import '../data/last_service.dart';
// import 'settings.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key}); // No userName required here

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0; // Track the selected tab

//   // Pages for each navigation item
//   final List<Widget> _pages = [
//     const HomeContent(), // Home content
//     const Center(child: Text("Search Page")), // Placeholder for search
//     const Center(child: Text("Settings Page")), // Placeholder for settings
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ServiceFormPage()),
//               );
//             } else if (index == 2) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const SettingsPage()),
//               );
//             }
//           });
//         },
//         selectedItemColor: mainColor,
//         unselectedItemColor: subText,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: "Add",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined),
//             label: "Settings",
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomeContent extends StatelessWidget {
//   const HomeContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const ProfileContainer(),
//             const SizedBox(height: 25),
//             Text(
//               "Last Service",
//               style: GoogleFonts.poppins(
//                   color: subText, fontSize: 12, fontWeight: FontWeight.w600),
//             ),
//             lastServiceList(),
//             const SizedBox(height: 8),
//             Text(
//               "Service List",
//               style: GoogleFonts.poppins(
//                   color: subText, fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 15),
//             SizedBox(
//               height: 80,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: serviceData.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       padding: const EdgeInsets.all(20),
//                       margin: const EdgeInsets.only(right: 18),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: mainColor,
//                       ),
//                       child: Image.asset(
//                         serviceData[index].logo.toString(),
//                         height: 20,
//                         width: 40,
//                       ),
//                     );
//                   }),
//             ),
//             const SizedBox(height: 25),
//             Text(
//               "Current Promotions",
//               style: GoogleFonts.poppins(
//                   color: subText, fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(
//               height: 120,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: articlesData.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 15),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 90,
//                             width: 90,
//                             margin: const EdgeInsets.only(right: 8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     articlesData[index].image.toString()),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 articlesData[index].title.toString(),
//                                 style: GoogleFonts.poppins(
//                                     color: mainColor,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w800),
//                               ),
//                               SizedBox(
//                                 width: 220,
//                                 child: Text(
//                                   articlesData[index].description.toString(),
//                                   maxLines: 4,
//                                   style: GoogleFonts.poppins(
//                                       color: subText,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   SizedBox lastServiceList() {
//     return SizedBox(
//       height: 190,
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: lastService.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 150,
//             height: 120,
//             margin: const EdgeInsets.fromLTRB(0, 15, 15, 15),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: index == 0 ? Colors.white : lastServiceAccent,
//               borderRadius: BorderRadius.circular(5),
//               boxShadow: [
//                 BoxShadow(
//                   color: index == 0
//                       ? subText.withOpacity(0.1)
//                       : Colors.white.withOpacity(0.1),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           lastService[index].day.toString(),
//                           style: GoogleFonts.poppins(
//                               color: subText,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         Text(
//                           lastService[index].clock.toString(),
//                           style: GoogleFonts.poppins(
//                               color: mainColor,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       lastService[index].serviceTime.toString(),
//                       style: GoogleFonts.poppins(
//                           color: mainColor,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Service",
//                   style: GoogleFonts.poppins(
//                       color: subText,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   lastService[index].desc.toString(),
//                   style: GoogleFonts.poppins(
//                       color: mainColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 10),
//                 Material(
//                   color: index == 0 ? blueAccent : mainColor,
//                   borderRadius: BorderRadius.circular(5),
//                   child: InkWell(
//                     splashColor: index == 0 ? mainColor : blueAccent,
//                     borderRadius: BorderRadius.circular(5),
//                     onTap: () {},
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(5),
//                       child: Text(
//                         "Detail",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Profile container as before
// class ProfileContainer extends StatelessWidget {
//   const ProfileContainer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: subText.withOpacity(0.1),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               // Image.asset(
//               //   "assets/images/profile_logo.png",
//               //   width: 40,
//               // ),
//               Icon(
//   Icons.account_circle,
//   size: 40,
//   color: Colors.grey,
// ),

//               const SizedBox(width: 15),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Welcome, Customer",
//                     style: GoogleFonts.poppins(
//                         color: mainColor,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     "Premium customer",
//                     style: GoogleFonts.poppins(
//                         color: subText,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const Icon(Icons.notifications_outlined, color: Colors.black, size: 30),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_car_service/style/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'service_form.dart';
import '../data/last_service.dart';
import 'settings.dart';
import 'locations.dart'; // Import Locations page

// / import 'package:flutter/material.dart';
// import 'package:flutter_car_service/style/color.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'service_form.dart'; // Import ServiceForm page
import 'package:flutter_car_service/data/articles_data.dart';
import 'package:flutter_car_service/data/service.dart';
// import '../data/last_service.dart';
// import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected tab

  // Pages for each navigation item
  final List<Widget> _pages = [
    const HomeContent(), // Home content
    const ServiceFormPage(), // Add service form
    const SettingsPage(), // Settings page
    const LocationsPage(), // Maps page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: mainColor,
        unselectedItemColor: subText,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "Maps",
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileContainer(),
            const SizedBox(height: 25),
            Text(
              "Last Service",
              style: GoogleFonts.poppins(
                  color: subText, fontSize: 12, fontWeight: FontWeight.w600),
            ),
            lastServiceList(),
            const SizedBox(height: 8),
            Text(
              "Service List",
              style: GoogleFonts.poppins(
                  color: subText, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 80,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: serviceData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mainColor,
                      ),
                      child: Image.asset(
                        serviceData[index].logo.toString(),
                        height: 20,
                        width: 40,
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 25),
            Text(
              "Current Promotions",
              style: GoogleFonts.poppins(
                  color: subText, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: articlesData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                    articlesData[index].image.toString()),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                articlesData[index].title.toString(),
                                style: GoogleFonts.poppins(
                                    color: mainColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                width: 220,
                                child: Text(
                                  articlesData[index].description.toString(),
                                  maxLines: 4,
                                  style: GoogleFonts.poppins(
                                      color: subText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  SizedBox lastServiceList() {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: lastService.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            height: 120,
            margin: const EdgeInsets.fromLTRB(0, 15, 15, 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: index == 0 ? Colors.white : lastServiceAccent,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: index == 0
                      ? subText.withOpacity(0.1)
                      : Colors.white.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lastService[index].day.toString(),
                          style: GoogleFonts.poppins(
                              color: subText,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          lastService[index].clock.toString(),
                          style: GoogleFonts.poppins(
                              color: mainColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      lastService[index].serviceTime.toString(),
                      style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Service",
                  style: GoogleFonts.poppins(
                      color: subText,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  lastService[index].desc.toString(),
                  style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Material(
                  color: index == 0 ? blueAccent : mainColor,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    splashColor: index == 0 ? mainColor : blueAccent,
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Detail",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 195, 165, 165),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class ProfileContainer extends StatelessWidget {
   const ProfileContainer({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Container(
       padding: const EdgeInsets.all(10),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
         boxShadow: [
           BoxShadow(
             color: subText.withOpacity(0.1),
             spreadRadius: 5,
             blurRadius: 7,
             offset: const Offset(0, 3),
           ),
         ],
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               Image.asset(
                 "assets/images/profile_logo.png",
                 width: 40,
               ),
               Icon(
   Icons.account_circle,
   size: 40,
   color: Colors.grey,
 ),

               const SizedBox(width: 15),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Welcome, Customer",
                     style: GoogleFonts.poppins(
                         color: mainColor,
                         fontSize: 15,
                         fontWeight: FontWeight.w700),
                   ),
                   Text(
                     "Premium customer",
                     style: GoogleFonts.poppins(
                         color: subText,
                         fontSize: 10,
                         fontWeight: FontWeight.w400),
                   ),
                 ],
               ),
             ],
           ),
           const Icon(Icons.notifications_outlined, color: Colors.black, size: 30),
         ],
       ),
     );
   }
 }