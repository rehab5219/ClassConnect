class StudentModel {
  String? name;
  String? image;
  String? email;
  String? phone1;
  String? uid;
   String? teacherId;

  StudentModel({
    this.name,
    this.image,
    this.email,
    this.phone1,
    this.uid,
    this.teacherId,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phone1 = json['phone1'];
    uid = json['uid'];
    teacherId = json['teacherId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['phone1'] = phone1;
    data['uid'] = uid;
    data['teacherId'] = teacherId;
    return data;
  }
}