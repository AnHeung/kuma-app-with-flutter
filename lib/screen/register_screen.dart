part of 'screen.dart';

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

    LoginUserData userData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text(kRegisterTermsTitle),
      ),
      body: BlocConsumer<RegisterBloc,RegisterState>(
            listener: (context,state){
              switch(state.status){
                case RegisterStatus.AlreadyInUse :
                  showToast(msg: RegisterStatus.AlreadyInUse.msg);
                  Navigator.pop(context);
                  break;
                case RegisterStatus.RegisterFailure :
                  showToast(msg: RegisterStatus.RegisterFailure.msg);
                  break;
                case RegisterStatus.RegisterComplete :
                  showToast(msg:RegisterStatus.RegisterComplete.msg);
                  Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
                  break;
                default:
                  break;
              }
            },
            builder: (context,state){
              RegisterStatus status = state.status;
              if(status == RegisterStatus.Loading){
                return const LoadingIndicator(isVisible: true);
              }else if(status == RegisterStatus.RegisterComplete){
                showToast(msg: kRegisterCompleteMsg);
              }

              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            CustomText(text:kRegisterAllTermsOkTitle , fontSize: kRegisterTitleFontSize, fontWeight: FontWeight.w700, fontColor: Colors.black, ),
                            const Spacer(),
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
                            CustomText(text:kRegisterTermsAgreeTitle,  fontSize: kRegisterFontSize, fontColor: Colors.black, ),
                            const Spacer(),
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
                            CustomText(text:kRegisterPrivacyInfoTitle ,   fontSize: kRegisterFontSize, fontColor: Colors.black,),
                            const Expanded(child: SizedBox()),
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
                      const Spacer(),
                      Container(
                        color: allTermCheck ? kBlue : Colors.black45,
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.bottomCenter,
                        child: SizedBox( height:50 , width: double.infinity ,child: TextButton(onPressed: ()=>{
                          if(allTermCheck){
                            BlocProvider.of<RegisterBloc>(context).add(UserRegister(userData: userData))
                          }
                        }, child: CustomText(fontColor:kWhite, text:kRegisterAllTermsCheckButton, fontSize: kRegisterTitleFontSize, fontFamily: doHyunFont,),)), )

                    ],
                  ),
                );
            },
          )
    );
  }
}
