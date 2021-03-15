
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/bloc/more/more_bloc.dart';
import 'package:kuma_flutter_app/enums/more_type.dart';
import 'package:kuma_flutter_app/routes/routes.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';

class MoreScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MoreBloc, MoreState>(
        builder: (context, state) {
          final status = context.select((AuthBloc bloc) => bloc.state.status);
          print('state :$status');
          if(status == AuthStatus.Auth){
            return _moreContainer(context);
          }else{
            return _needLoginContainer(context);
          }
        },
      );
  }
  Widget _moreContainer(BuildContext context){

    double statusBarHeight = MediaQuery.of(context).padding.top + 20;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight ,left: 20 , right: 20),
        child: Column(
          children: [
            Container(alignment :Alignment.centerLeft,child: CustomText(text:'더보기' , fontSize: 20, fontWeight: FontWeight.w700, fontColor: Colors.black,)),
           _topContainer()
          ],
        ),
      ),
    );
  }

   Widget _topContainer(){

    return  ListView.separated(separatorBuilder: (context, idx){
         return SizedBox(
           height: 10,
         );
       }, physics: BouncingScrollPhysics(),
         scrollDirection: Axis.vertical,
         itemCount: MoreType.values.length,
         shrinkWrap: true,
         itemBuilder: (context,idx){
          final IconData icon = MoreType.values[idx].icon;
          final String title = MoreType.values[idx].title;
          final MoreType type = MoreType.values[idx];
           return GestureDetector(
             onTap: (){
               switch(type){
                 case MoreType.Account:
                   break;
                 case MoreType.Notification:
                   break;
                 case MoreType.Logout:
                   BlocProvider.of<AuthBloc>(context).add(SignOut());
                   break;
                 case MoreType.VersionInfo:
                   break;
               }
             },
             child: Container(
               height: 50,
               child: Row(
                   children: [
                     Icon(icon),
                     Padding(
                       padding: const EdgeInsets.only(left:10.0),
                       child: CustomText(text:title , fontColor: Colors.black, fontSize: 15,),
                     ),
                   ],
                 ),
             ),
           );
         },);
  }

  Widget _needLoginContainer(BuildContext context){

    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('로그인이 되어 있지 않습니다.'),
            Container(
              height: 30,
              margin: EdgeInsets.only(top: 10),
              color: Colors.blue,
              child: TextButton(
                  onPressed: ()=>{
                    Navigator.pushNamed(context, Routes.LOGIN)
                  }, child: CustomText(text: "로그인/회원가입", fontSize: 13,)),
            )
          ],
        ),
      ),
    );
  }
}
