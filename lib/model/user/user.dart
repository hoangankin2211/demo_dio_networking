import '../../index.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "userData")
  Data data;

  User(this.data);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
