class MemberModel {
  final int memberId;
  final String uniqueKey;
  final int memberIndex;
  final String relation;

  MemberModel({
    required this.memberId,
    required this.uniqueKey,
    required this.memberIndex,
    required this.relation,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberId: json["memberId"],
      uniqueKey: json["uniqueKey"],
      memberIndex: json["memberIndex"],
      relation: json["relation"] ?? "알수없음",
    );
  }
}
