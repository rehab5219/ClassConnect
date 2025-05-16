class TeacherModel {
  String? name;
  String? image;
  String? specialization;
  String? email;
  String? phone1;
  String? bio;
  String? uid;

  TeacherModel({
    this.name,
    this.image,
    this.specialization,
    this.email,
    this.phone1,
    this.bio,
    this.uid,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    specialization = json['specialization'];
    email = json['email'];
    phone1 = json['phone1'];
    bio = json['bio'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['specialization'] = specialization;
    data['email'] = email;
    data['phone1'] = phone1;
    data['bio'] = bio;
    data['uid'] = uid;
    return data;
  }
}