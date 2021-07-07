
import 'package:flutter/cupertino.dart';


//카카오 key
const KakaoClientId = "c2de908819754be96af4d46766eaa8eb";
const KakaoJavascriptClientId = "145316ccaf6edd8159668aee4133c4a5";

//메인 바텀 탭
const String kAppTabAnimationTitle = "애니";
const String kAppTabGenreTitle = "장르검색";
const String kAppTabNewsTitle = "뉴스";
const String kAppTabMoreTitle = "더보기";

//공통
const String kAppTitle = "쿠마앱";
const String kEmptyScreenDefaultMsg = "정보가 없습니다.";
const double kAppbarTitleFontSize = 20;
const String kStartDate = "2000-01-01";
const String kTimeFormat = "yyyy-MM-dd";
const String kInitialPage = "1";
const kNoImageUri = "assets/images/no_image.png";
const kNoImage =  const AssetImage(
  kNoImageUri,
);
const String kUndoTitle = "되돌리기";
const double kDefaultFontSize = 13;
const double kDefaultEmptyContainerFontSize = 20;
const double kDefaultImageScrollContainerHeight = 150;
const int kDefaultImageDiveRate = 3;
const double kDefaultSeparatorMidGap = 8;
const double kDefaultSeparatorTopGap = 2;

//에러
const String kErrorTitle = "에러 발생";
const String kErrorTerminateTitle = "앱종료";


//네트워크
const String kRetryInfoMsg = "시간이 초과했습니다. 앱을 다시 실행해주세요";

// Colors
const Color kBlue = Color(0xFF306EFF);
const Color kLightBlue = Color(0xFF4985FD);
const Color kDarkBlue = Color(0xFF1046B3);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFF828282);
const Color kBlack = Color(0xFF2D3243);
const Color kPurple = Color(0xFF6464FF);
const Color kSoftPurple = Color(0xFF736AB7);
const Color kDisabled = Color(0xFFdcdcdc);
const Color kGreen = Color(0xFF18CCA8);

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
const int kSplashTime = 2;

// Assets
const String kGoogleLogoPath = "assets/images/google_logo.png";
const String doHyunFont = "DoHyeon";
const String nanumFont = "NanumPenScript";
const String nanumGothicFont = "NanumGothic";

//설정
const Map<String,String> kCategoryList = {"airing":"상영중","upcoming":"상영예정","movie":"극장판","ova":"OVA" ,"tv":"TV"};
const double kSettingFontSize = 13;
const double kSettingContainerHeight = 70;
const String kBaseRankItem = "airing,upcoming,movie";
const String kBaseHomeItemCount = "30";
const String kSettingLoadErrMsg = "설정오류 다시 시도해주세요";
const String kSettingGenreCategoryTitle = "표시할 카테고리";
const String kSettingNoUserErrMsg = "유저아이디 정보가 없습니다.";
const String kSettingChangeErrMsg = "정보변경 실패 다시 시도해주세요";
const String kSettingAccountTitle = "계정 설정";
const String kSettingHomeAutoScrollTitle = "홈화면 자동 스크롤";
const String kSettingNotificationTitle = "알림설정";
const String kSettingHomeItemTitle = "홈화면에 보여줄 아이템 갯수";
const List<String> kSettingHomeItemCountList = [
  "5",
  "10",
  "15",
  "20",
  "25",
  "30",
];

//더보기
const String kMoreAppbarTitle = "더보기";
const double kMoreFontSize = 15;
const double kMoreLoginFontSize = 10;
const double kMoreContainerHeight = 70;
const double kMoreTitleFontSize = 20;
const String kMoreVersionInfoTitle = "버전 정보";
const String kMoreLogoutInfoMsg = "로그아웃 하시겠습니까?";
const String kMoreNoLoginTitle = "로그인이 되어 있지 않습니다.";
const String kLogoutInfoTitle = "로그아웃";
const String kMoreAccountTitle = "계정 설정";
const String kMoreSettingTitle = "설정";


//구독
const String kSubscribeCheckErrMsg = "구독 목록 가져오기 실패";
const String kSubscribeUpdateErrMsg = "구독에러 재시도 해주세요";

//View_Util
const double dialogFontSize = 20;
const double toastFontSize = 15;

//알림내역
const double kNotificationItemHeight = 90;
const double kNotificationItemWidth = 70;
const double kNotificationTitleImageSize = 50;
const double kNotificationTitleFontSize = 16;
const double kNotificationFontSize = 12;
const double kNotificationMargin = 10;
const String kNotificationNoNotificationMsg = "알림 내역이 없습니다.";
const String kNotificationAppbarTitle = "알림내역";

//애니메인
const double kAnimationFontSize = 15;
const double kAnimationTitleFontSize = 20;
const double kAnimationItemTitleFontSize = 20;
const double kMainAppbarExpandedHeight = 450;
const double kAnimationScheduleContainerHeight = 260;
const double kAnimationRankContainerHeight = 260;
const double kAnimationRankContainerHeightRate = 0.4;
const String kAnimationScheduleTitle = "요일별 신작";
const String kAnimationAppbarTitle = "ANIMATION";
const kSeasonLimitCount = "7";
final List<String> kAnimationScheduleDayList = ["월","화","수","목","금","토","일"];
const double AnimationNotificationIconSize = 30;
const double AnimationNotificationIconTxtContainerSize = 15;
const double AnimationNotificationIconTxtSize = 7;

//애니 상세페이지
const double kTopImageContainerHeightRate = 0.25;
const double kTopImageWidthRate = 0.4;
const double kTopContainerHeightRate = 0.5;
const double kTopContainerIndicatorRate = 0.82;
const double kAnimationDetailGenreFontSize = 8;
const double kAnimationDetailFontSize = 15;
const double kAnimationDetailIndicatorFontSize = 10;
const double kAnimationDetailTitleFontSize = 25;
const double kAnimationImageContainerHeight = 200;
const String kAnimationDetailRelateTitle = "관련애니";
const String kAnimationDetailRecommendTitle = "추천애니";
const String kAnimationDetailImageTitle = "이미지";
const String kAnimationDetailCharacterTitle = "등장인물";
const String kAnimationDetailSynopsisTitle = "개요";
const String kAnimationDetailNoRanking = "랭킹:기록없음";
const String kAnimationDetailNoEpisode = "화수:정보없음";
const String kAnimationDetailSubscribeTitle = "화수:정보없음";
const String kAnimationDetailUnsubscribeInfoMsg = "구독해지 하시겠습니까?";
const String kAnimationDetailSubscribeInfoMsg = "구독하시겠습니까? 구독하면 해당 애니메이션 관련 알림이 날라옵니다.";
const String kAnimationDetailPopupMenuAddBatchTitle = "배치에 추가";
const String kAnimationDetailPopupMenuRefreshTitle = "새로고침";

//BottomContainer
const String kBottomContainerVoiceTitle = "성우";
const String kBottomContainerCharacterTitle = "맡은캐릭터";
const String kBottomContainerIntroduceTitle = "소개";
const String kBottomContainerSiteTitle = "사이트";
const String kBottomContainerImageTitle = "이미지";

//검색 이력
const int kSearchGridCount = 3;
const kSearchHistoryPath = "search_history.json";
const kSearchHistoryDeleteErrMsg = "검색목록 삭제 실패";
const kSearchHistoryLoadErrMsg = "데이터를 가져오는데 실패했습니다.";
const kSearchHistoryWriteErrMsg = "데이터를 기록하는데 실패했습니다.";
const kSearchHistoryDeleteTitle = "기록 전체삭제";
const kSearchHistoryDeleteMsg = "저장된 기록을 다 지우시겠습니까?";

//검색 페이지
const kSearchHint = "검색...";
const kSearchInitTitle = "검색페이지";
const double kSearchImageItemContainerHeight = 80;
const double kSearchItemContainerMinHeight = 50;
const double kSearchItemContainerMaxHeightRate = 0.6;
const double kSearchImageItemSize = 40;
const double kSearchItemContainerSymmetricMargin = 30;


//계정 페이지
const double kAccountFontSize = 12;
const double kAccountTitleFontSize = 15;
const double kAccountItemHeight = 40;
const double kAccountWithdrawBtnHeight = 50;
const String kAccountTitle = "계정";
const String kAccountNickName = "닉네임";
const String kAccountEmail = "이메일";
const String kAccountSocial = "소셜";
const String kAccountConfig = "계정 설정";
const String kAccountLoginType = "로그인 타입";
const String kAccountWithdrawTitle = "회원탈퇴";
const String kAccountWithdrawInfoMsg = "회원탈퇴를 하시겠습니까?";
const String kAccountWithdrawButtonTitle = "탈퇴하기";


//로그인 페이지
const double kLoginFontSize = 12;
const String kLoginKakao ="카카오 로그인";
const String kLoginGoogle ="구글 로그인";
const String kLoginEmail ="이메일 로그인";
const String kLoginTitle ="로그인";
const String kLoginDialogTitle = "로그인/회원가입";
const String kLoginDialogPwTitle = "비밀번호";
const String kLoginDialogIdTitle = "이메일";

//회원가입 페이지
const double kRegisterFontSize = 15;
const double kRegisterTitleFontSize = 20;
const String kRegisterTermsTitle = "약관동의";
const String kRegisterCompleteMsg = "등록 성공";
const String kRegisterAllTermsOkTitle = "모든 약관에 동의";
const String kRegisterTermsAgreeTitle = "이용에 대한 동의(필수)";
const String kRegisterPrivacyInfoTitle = "이용에 대한 동의(필수)";
const String kRegisterAllTermsCheckButton = "확인";

//장르검색
const double kGenreTopItemHeight = 60;
const double kGenreFilterItemHeight = 30;
const double kGenreItemContainerHeight = 60;
const String kGenreFilterRemoveTitle = "필터 삭제";
const String kGenreSearchAppbarTitle = "장르 검색";
const String kGenreFilterRemoveMsg = "필터를 전부 삭제하시겠습니까?";

//뉴스
const double kNewsItemContainerHeight = 100;
const double kNewsItemContainerWidth = 100;
const double kNewsSymmetricMargin = 24;
const double kNewsContentLeftMargin = 45;