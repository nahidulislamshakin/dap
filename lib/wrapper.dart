import 'package:dap/account.dart';
import 'package:dap/firebase/firebase_auth/authentication.dart';
import 'package:dap/widgets/home_page.dart';
import 'package:dap/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  Widget build(BuildContext context){
    final _authService = Provider.of<Authentication>(context);


    return StreamBuilder<UserAccount?>(
        stream: _authService.user,
        builder: (context, AsyncSnapshot<UserAccount?> snapshot){
      if(snapshot.connectionState == ConnectionState.active){
        final UserAccount? user = snapshot.data;
        return user == null ? Login_Page() : Home_Page();
        // return if(user == null){
        //
        // }else {
        //
        // }

      }else{
        return  Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 15,),
                Text("Please connect to the internet"),
              ],
            ),
          ),
        );
      }
    });
  }
}