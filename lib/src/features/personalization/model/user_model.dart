import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kirei/src/utils/formaters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture});

  /// Get the Full Name
  String get fullName => '$firstName $lastName';

  /// Get Formatted Phone Number
  String get formattedPhoneNo => AppFormatter.formatPhoneNumber(phoneNumber);

  /// Split full name into two part
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Generate username from full name
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = "$firstName$lastName";
    String userNameWithPrefix = "cwt_$camelCaseUserName";
    return userNameWithPrefix;
  }

  /// function for create a empty user model
  static UserModel empty() =>
      UserModel(
          id: "",
          firstName: "",
          lastName: "",
          userName: "",
          email: "",
          phoneNumber: "",
          profilePicture: "");

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(id: document.id,
          firstName: data['firstName'] ?? '',
          lastName: data['lastName'] ?? '',
          userName: data['userName'] ?? '',
          email: data['email'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          profilePicture: data['profilePicture'] ?? '');
    }else{
      return UserModel.empty();
    }
  }
}
