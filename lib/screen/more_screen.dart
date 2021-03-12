
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/auth/auth_bloc.dart';
import 'package:kuma_flutter_app/bloc/login/login_bloc.dart';
import 'package:kuma_flutter_app/bloc/more/more_bloc.dart';
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
    return Center(
      child: TextButton(
        onPressed: ()=>{
          BlocProvider.of<LoginBloc>(context).add(Logout(type:SocialType.KAKAO, context: context))
        },
        child: Text('로그아웃'),
      ),
    );
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
