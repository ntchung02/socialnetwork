import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x/api/auth_api.dart';
import 'package:x/api/user_api.dart';
import 'package:x/core/utils.dart';
import 'package:x/features/auth/view/login_view.dart';
import 'package:x/features/home/view/home_view.dart';
import 'package:x/models/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPTProvider),
    userAPI: ref.watch(userAPIProvider),

  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDatailsProvider(currentUserId));
  return userDetails.value;
});

final userDatailsProvider = FutureProvider.family((ref, String uid)  {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool>{
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  }): _authAPI = authAPI,
      _userAPI = userAPI,
   super(false);

   Future<model.User?> currentUser() => _authAPI.currentUserAccount();


  void SignUp({
    required String email,
    required String password,
    required BuildContext context,

  })async{
    state = true;
    final res  = await _authAPI.signUp(
      email: email, 
      password: password,
      );
      state = false;
      res.fold(
        (l) => showSnackBar(context, l.message),
         (r) async {
          UserModel userModel = UserModel(
            email: email,
            name: getNameFromEmail(email), 
            followers: const [], 
            following: const [],
            profilePic: '', 
            bannerPic: '', 
            uid: r.$id, 
            bio: '', 
            isTwitterBlue: false,
            );
          final res2 = await _userAPI.saveUserData(userModel);
          res2.fold((l) => showSnackBar(context, l.message), (r) {
             showSnackBar(context, 'account created! Please login');
          Navigator.push(context, LoginView.route());
          });

         
         },
      );
  }

  void Login({
    required String email,
    required String password,
    required BuildContext context,

  })async{
    state = true;
    final res  = await _authAPI.Login(
      email: email, 
      password: password,
      );
      state = false;
      res.fold(
        (l) => showSnackBar(context, l.message),
         (r) {
          Navigator.push(context, HomeView.route());
         },
      );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
  
}