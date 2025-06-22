class StudentModel {
  String? firstName;
  String? secondName;
  String? image;
  String? email;
  String? phone1;
  String? uid;
  String? teacherId; // Keep this for backward compatibility if needed
  List<String>? teacherIds; // New field for multiple teacher IDs

  StudentModel({
    this.firstName,
    this.secondName,
    this.image,
    this.email,
    this.phone1,
    this.uid,
    this.teacherId,
    this.teacherIds,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    secondName = json['secondName'];
    image = json['image'];
    email = json['email'];
    phone1 = json['phone1'];
    uid = json['uid'];
    teacherId = json['teacherId'];
    teacherIds = List<String>.from(json['teacherIds'] ?? []); // Default to empty list if null
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['secondName'] = secondName;
    data['image'] = image;
    data['email'] = email;
    data['phone1'] = phone1;
    data['uid'] = uid;
    data['teacherId'] = teacherId;
    data['teacherIds'] = teacherIds ?? []; // Include teacherIds in the JSON
    return data;
  }
}