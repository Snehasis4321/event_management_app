import 'package:appwrite/appwrite.dart';
import 'package:event_management_app/database.dart';
import 'package:event_management_app/saved_data.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('64b4fc61e5f4aa023618')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development

Account account = Account(client);
// Register User
Future<String> createUser(String name, String email, String password) async {
  try {
    final user = await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    saveUserData(name, email, user.$id);
    return "success";
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}

// Login User

Future loginUser(String email, String password) async {
  try {
    final user =
        await account.createEmailSession(email: email, password: password);
    SavedData.saveUserId(user.userId);
    getUserData();
    return true;
  } on AppwriteException catch (e) {
    return false;
  }
}

// Logout the user
Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
}

// check if user have an active session or not

Future checkSessions() async {
  try {
    await account.getSession(sessionId: 'current');
    return true;
  } catch (e) {
    return false;
  }
}
