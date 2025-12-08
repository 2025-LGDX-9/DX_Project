
// main 함수 - 실행
void main() {
  // 다트언어의 데이터 타입
  // bool - boolean
  // 정수 - int
  // 실수 - double
  // 숫자 타입 - num(타입이 존재하기 때문에 변수이름으로 사용하지 말것!)
  // 문자열 - String

  // 변수 선언 방법 - java와 동일
  int num1 = 10;
  bool b = true;
  print(num1); // 회색밑줄 -> 링트라고 부름. hint를 주는 밑줄
  print(b);

  // 문자열
  String s1 = "hello";
  // dart에서 문자열은 "",'' 두 개를 구분하지 않음!
  String s2 = 'world';
  String s3 = """hello 
  world
  nice
  to
  meet
  you""";
  print(s3);

  // 문자열 포매팅
  print("s1의 값은 : $s1");

  // 연산이나 객체 값을 가지고 오는 포매팅 -> ${연산, 객체값}
  // int num1에 담긴 10이란 숫자를 +5해서 출력
  print("num1에서 5를 더한 값 ${num1 + 5}");

  // var 타입 - 타입에 상관없이 값 할당 가능
  // 타입이 한번 설정되면 바뀌지 않음
  var num2 = 10;
  num2 = 20;
  // num2 = "안녕"; // 한번 설정한 변수는 타입이 바뀌지 않음
  // dynamic 타입 - 타입에 상관없이 값 할당 가능. 타입이 고정되어있지 않음
  


}