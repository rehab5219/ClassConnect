class TeacherModel {
  String? firstName;
  String? secondName;
  String? image;
  String? specialization;
  String? email;
  String? phone1;
  String? bio;
  String? uid;
  List<String>? students;

  TeacherModel({
    this.firstName,
    this.secondName,
    this.image,
    this.specialization,
    this.email,
    this.phone1,
    this.bio,
    this.uid,
    this.students,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    secondName = json['secondName'];
    image = json['image'];
    specialization = json['specialization'];
    email = json['email'];
    phone1 = json['phone1'];
    bio = json['bio'];
    uid = json['uid'];
    students = json['students'] != null ? List<String>.from(json['students']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['secondName'] = secondName;
    data['image'] = image;
    data['specialization'] = specialization;
    data['email'] = email;
    data['phone1'] = phone1;
    data['bio'] = bio;
    data['uid'] = uid;
    data['students'] = students ?? [];
    return data;
  }
}