import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getCurrentAddress() async {
  bool serviceEnabled;
  LocationPermission permission;

  // 위치 서비스 ON 확인
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return "위치 서비스 꺼짐";
  }

  // 권한 체크
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return "위치 권한 거부됨";
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return "위치 권한 영구 거부됨";
  }

  // ✔ 현재 위치 받기
  Position pos = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // ✔ 좌표 → 주소 변환
  List<Placemark> placemarks =
  await placemarkFromCoordinates(pos.latitude, pos.longitude);

  Placemark place = placemarks.first;

  // 🤍 반환 형식 (원하는 대로 변경 가능)
  // 예: 서울특별시 강남구 역삼동
  String address =
      "${place.administrativeArea} ${place.locality} ${place.subLocality}";

  return address;
}