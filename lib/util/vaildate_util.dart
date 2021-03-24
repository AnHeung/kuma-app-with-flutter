
validateEmail (String email)=>RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) ? null :  "이메일을 형식에 맞게 입력해주세요";

validateUserPw (String pw)=>RegExp(r"^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(pw) ? null :  "비밀번호를 맞게 써주세요(최소8자 특수문자 하나 포함)";