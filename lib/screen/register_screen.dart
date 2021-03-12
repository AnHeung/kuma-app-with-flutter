import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/register/register_bloc.dart';
import 'package:kuma_flutter_app/model/api/social_user.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/custom_text.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class RegisterScreen extends StatefulWidget {


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var firstTermCheck = false;
  var secondTermCheck = false;
  var allTermCheck = false;


  @override
  Widget build(BuildContext context) {

    SocialUserData userData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('약관동의'),
      ),
      body: BlocBuilder<RegisterBloc,RegisterState>(
            builder: (context,state){
              RegisterStatus status = state.status;
              if(status == RegisterStatus.Loading){
                return LoadingIndicator(isVisible: true);
              }else if(status == RegisterStatus.RegisterComplete){
                showToast(msg: "등록성공");
              }

              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            TextButton(onPressed: ()=>{}, child: CustomText(text:'모든 약관에 동의' , fontSize: 20, fontWeight: FontWeight.w700, fontColor: Colors.black, ),),
                            Expanded(child: SizedBox()),
                            Checkbox(value: allTermCheck, onChanged: ((value)=>{
                              setState((){
                                allTermCheck = value;
                                firstTermCheck = value;
                                secondTermCheck = value;
                              })
                            }))
                          ],
                        ),),
                      Container(
                        child: Row(
                          children: [
                            TextButton(onPressed: ()=>{}, child: CustomText(text:'이용에 대한 동의(필수)',  fontSize: 15, fontColor: Colors.black, ),),
                            Expanded(child: SizedBox()),
                            Checkbox(value: firstTermCheck, onChanged: (bool value){
                              setState(() {
                                firstTermCheck = value;
                                if(secondTermCheck == firstTermCheck){
                                  allTermCheck = value;
                                }else if(allTermCheck){
                                  allTermCheck = value;
                                }
                              });
                            }),
                          ],
                        ),),
                      Container(
                        child: Row(
                          children: [
                            TextButton(onPressed: ()=>{}, child: CustomText(text:'개인정보수집 이용에 대한 안내' ,   fontSize: 15, fontColor: Colors.black,),),
                            Expanded(child: SizedBox()),
                            Checkbox(value: secondTermCheck, onChanged: (value)=>{
                              setState(() {
                                secondTermCheck = value;
                                if(secondTermCheck == firstTermCheck){
                                  allTermCheck = value;
                                }else if(allTermCheck){
                                  allTermCheck = value;
                                }
                              })
                            }),
                          ],
                        ),),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        color: allTermCheck ? Colors.blue : Colors.black45,
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        alignment: Alignment.bottomCenter,
                        child: SizedBox( height:50 , width: double.infinity ,child: TextButton(onPressed: ()=>{
                          if(allTermCheck){
                            BlocProvider.of<RegisterBloc>(context).add(UserRegister(userData: userData))
                          }
                        }, child: CustomText(text:'완료', fontSize: 20,),)), )

                    ],
                  ),
                );
            },
          )
    );
  }
}