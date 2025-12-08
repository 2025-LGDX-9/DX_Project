void main() {
  // 함수 문법
  // python --> def 함수명():
  // java --> 접근제한자(public) return타입(void) 함수명(){}

  // dart --> return타입(void) 함수명(){}
  // dart에서는 접근제한자가 public과 private 두개만 사용함

  int result = addNum(10, 11);
  print(result);

  positionMethod(10);
  positionMethod(11, "안녕");
  positionMethod(11, "hello", "안녕");
  namedMethod(10);
  namedMethod(10, right: 1); // 바꾸고 싶은 값을 이름으로 찾아서 변경한다
}

// 명명적 매개변수
void namedMethod(int num1, {int left = 10, int right = 20}) {
  print("$num1, $left, $right"); // 매개변수 명명
}
  // 리턴 타입 O, 매개변수 O
  int addNum(int num1, int num2) {
    // 매개변수의 타입을 작성
    // 매개변수 타입 생략 가능! --> 생략하면 dynamic타입으로 변경됨(다 받아줄 수 있음)
    return num1+num2;
  }

  // 위치적 매개변수, 명명적 매개변수

// 위치적 매개변수
void positionMethod(int num1, [String s1 = "hello", String s2 = "world"]) {
  print("$num1, $s1, $s2");
}
