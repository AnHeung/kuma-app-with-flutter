
import 'package:flutter/cupertino.dart';

const List<String> itemCountList = [
  "5",
  "10",
  "15",
  "20",
  "25",
  "30",
  "35",
  "40",
  "45",
  "50"
];

const Map<String,String> categoryList = {"airing":"상영중","upcoming":"상영예정","movie":"극장판","ova":"OVA","tv":"TV"};
final List<String> dayList = ["월","화","수","목","금","토","일"];

const Map<String,String> genreList = {"액션":"1","어드벤쳐":"2","코미디":"4","드라마" :"8","호러":"14","음악":"19" ,"패러디" :"20" , "로맨스":"22" ,
  "우주":"29","스포츠" :"30" ,"밀리터리":"38", "스릴러":"41" };

// Colors
const Color kBlue = Color(0xFF306EFF);
const Color kLightBlue = Color(0xFF4985FD);
const Color kDarkBlue = Color(0xFF1046B3);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFFF4F5F7);
const Color kBlack = Color(0xFF2D3243);
const Color kDisabled = Color(0xFFdcdcdc);

// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;

// Animation
const Duration kButtonAnimationDuration = Duration(milliseconds: 600);
const Duration kCardAnimationDuration = Duration(milliseconds: 400);
const Duration kRippleAnimationDuration = Duration(milliseconds: 400);
const Duration kLoginAnimationDuration = Duration(milliseconds: 1500);

// Assets
const String kGoogleLogoPath = 'assets/images/google_logo.png';
const String doHyunFont = 'DoHyeon';
const String nanumFont = 'NanumPenScript';
const String nanumGothicFont = 'NanumGothic';

//Setting
const double kSettingFontSize = 13;

//더보기
const double kMoreFontSize = 15;
const double kMoreLoginFontSize = 10;
const double kMoreTitleFontSize = 20;

//View_Util
const double dialogFontSize = 20            ;
const double toastFontSize = 15;



//애니메인
const double kAnimationFontSize = 15;
const double kAnimationTitleFontSize = 20;
const double kAnimationItemTitleFontSize = 20;
const double kMainAppbarExpandedHeight = 450;
const double kAnimationScheduleContainerHeight = 260;
const double kAnimationRankingContainerHeightRate = 0.4;
const String kAnimationScheduleTitle = "요일별 신작";
const String kAnimationAppbarTitle = "ANIMATION";

//애니상세
const double kAnimationDetailGenreFontSize = 8;
const double kAnimationDetailFontSize = 15;
const double kAnimationDetailIndicatorFontSize = 10;
const double kAnimationDetailTitleFontSize = 25;
const double kAnimationImageContainerHeight = 150;
const String kAnimationDetailRelateTitle = "관련애니 목록";
const String kAnimationDetailRecommendTitle = "추천애니 목록";
const String kAnimationDetailImageTitle = "이미지";
const String kAnimationDetailSynopsisTitle = "개요";

//계정페이지
const double kAccountFontSize = 15;
const double kAccountTitleFontSize = 20;
const double kAccountItemHeight = 40;

//로그인 페이지
const double kLoginFontSize = 12;

//회원가입 페이지
const double kRegisterFontSize = 15;
const double kRegisterTitleFontSize = 20;