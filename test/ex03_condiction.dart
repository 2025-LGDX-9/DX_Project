void main() {

  // 문법
  // switch(식) {
  // case 값 :
  //}
  // dart 3버전 업뎃이후 break 생략가능!!
  String text = "hello";
  switch(text) {
    case "hello" :
      print("안녕");
    case "world" :
      print("세상");

      default:
      print("잘 모르겠습니다.");
  }

  // 비교도 가능
  int num1 = -10;
  switch(num1) {
    case > 0 :
      print("양수 입니다.");
    case < 0 :
      print("음수 입니다.");
    default :
      print("0입니다.");
  }
}