// import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
// import 'package:falcanli/View/UserViews/ProfileView/Pages/complete_profile_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';

// class ProfileSettings extends StatelessWidget {
//   List profileSettingsList = [
//     {
//       "title": "Profil Bilgilerim",
//       "page": CompleteProfileView(),
//     },
//     {
//       "title": "Bize Ulaşın",
//       "page": Container(),
//     },
//     {
//       "title": "Profil Bilgilerim",
//       "page": Container(),
//     },
//     {
//       "title": "Profil Bilgilerim",
//       "page": Container(),
//     },
//     {
//       "title": "Profil Bilgilerim",
//       "page": Container(),
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(title: "Profil Ayarlarım"),
//       body: ListView.builder(
//         itemCount: profileSettingsList.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//             child: Card(
//               child: ListTile(
//                 onTap: () => Get.to(profileSettingsList[index]["page"]),
//                 title: Text(profileSettingsList[index]['title']),
//                 trailing: const Icon(Icons.settings),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
