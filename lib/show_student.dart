// import 'package:flutter/material.dart';
// import 'widgets/create_account_page.dart';
// import 'widgets/login_page.dart';

// class ShowStudent extends StatelessWidget{
//   final index;
//   ShowStudent({required this.index});
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       //color: Colors.green.shade100,
//     width: double.infinity,
//     margin: EdgeInsets.all(10),
//     padding: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//     border: Border.all(color: Colors.green.shade400,),
//     borderRadius: BorderRadius.circular(8),
//     boxShadow: [
//     new BoxShadow(color: Colors.green.shade400, offset: new Offset(6.0, 6.0),),
//     ],
//     ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("${studentList[index].name}"),
//             Text("${studentList[index].id}"),
//             Text("${studentList[index].email}"),
//             Text("0${studentList[index].number?.round()}"),

//           ],
//       )
//     );
//   }
// }