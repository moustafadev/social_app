import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/comment_model.dart';
import 'package:social/models/create_post_model.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/request_friends_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/chats/chats_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';
import 'package:social/modules/profile/profile_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/componets/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  int currentIndex = 0;

  List<Widget> pagesScreen = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];
  List<String> label = [
    'Home',
    'Chat',
    'User',
    'Profile',
  ];

  void changeNavbarBottom({required int index}) {
    if (index == 1) {
      getAllUsers();
    }
    currentIndex = index;
    emit(ChangeNavbarBottomStates());
  }

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      print(value.id);
      emit(SocialGetUserSuccessStates());
    }).catchError(
      (error) {
        print('error << $error >>');
        emit(SocialGetUserErrorStates());
      },
    );
  }

  File? profileImage;
  final ImagePicker profileImagePicker = ImagePicker();

  Future<void> getFromImage() async {
    final pickedFileImage = await profileImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFileImage != null) {
      profileImage = File(pickedFileImage.path);
      emit(SocialUpdateImageProfileSuccessStates());
    } else {
      print('Error in image');
      emit(SocialUpdateImageProfileErrorStates());
    }
  }

  File? profileCover;
  final ImagePicker profileCoverPicker = ImagePicker();

  Future<void> getFromCover() async {
    final pickedFileCover = await profileCoverPicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFileCover != null) {
      profileCover = File(pickedFileCover.path);
      emit(SocialUpdateCoverImageProfileSuccessStates());
    } else {
      print('Error in image');
      emit(SocialUpdateCoverImageProfileErrorStates());
    }
  }

  void uploadProfileImage({
    required String phone,
    required String name,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          print('<< $value >>');
          updateUser(
            phone: phone,
            name: name,
            bio: bio,
            image: value,
          );
          emit(SocialUploadImageProfileSuccessStates());
        },
      ).catchError(
        (error) {
          emit(SocialUploadImageProfileErrorStates());
        },
      );
    }).catchError(
      (error) {
        print(error.toString());
        emit(SocialUploadImageProfileErrorStates());
      },
    );
  }

  void uploadProfileCover({
    required String phone,
    required String name,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileCover!.path).pathSegments.last}')
        .putFile(profileCover!)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          print(value);
          updateUser(
            phone: phone,
            name: name,
            bio: bio,
            cover: value,
          );
          emit(SocialUploadCoverImageProfileSuccessStates());
        },
      ).catchError(
        (error) {
          emit(SocialUploadCoverImageProfileErrorStates());
        },
      );
    }).catchError(
      (error) {
        print(error.toString());
        emit(SocialUploadCoverImageProfileErrorStates());
      },
    );
  }

  void updateUser({
    required String phone,
    required String name,
    required String bio,
    String? cover,
    String? image,
  }) {
    print(model!.image);
    SocialUserModel models = SocialUserModel(
      phone: phone,
      name: name,
      uId: uId,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      bio: bio,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(models.toMap())
        .then(
      (value) {
        getUserData();
      },
    ).catchError(
      (error) {
        emit(SocialUpdateUserErrorStates());
      },
    );
    print(models.image);
  }

  void updateUserProfile({
    required String phone,
    required String name,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingStates());
    if (profileCover != null) {
      uploadProfileCover(
        phone: phone,
        name: name,
        bio: bio,
      );
    }
    if (profileImage != null) {
      uploadProfileImage(
        phone: phone,
        name: name,
        bio: bio,
      );
    }
  }

  File? createNewPost;
  final ImagePicker createNewPostPicker = ImagePicker();

  Future<void> getImagePost() async {
    final pickedFileCover = await createNewPostPicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFileCover != null) {
      createNewPost = File(pickedFileCover.path);
      emit(SocialUpdateCoverImageProfileSuccessStates());
    } else {
      print('Error in image');
      emit(SocialUpdateCoverImageProfileErrorStates());
    }
  }

  void uploadNewPostImage({
    required String dataTime,
    required String text,
    String? postImage,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(createNewPost!.path).pathSegments.last}')
        .putFile(createNewPost!)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          createPost(
            dataTime: dataTime,
            text: text,
            postImage: value,
          );
          emit(SocialUploadCoverImageProfileSuccessStates());
        },
      ).catchError(
        (error) {
          emit(SocialUploadCoverImageProfileErrorStates());
        },
      );
    }).catchError(
      (error) {
        print(error.toString());
        emit(SocialUploadCoverImageProfileErrorStates());
      },
    );
  }

  CreatePostModel? modelPost;

  void createPost(
      {required String dataTime, required String text, String? postImage}) {
    emit(SocialCreateNewPostLoadingStates());
    CreatePostModel modelPost = CreatePostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dataTime: dataTime,
      text: text,
      postImage: postImage,
    );

    FirebaseFirestore.instance
        .collection('post')
        .add(modelPost.toMapPost())
        .then(
      (value) {
        emit(SocialCreateNewPostSuccessStates());
      },
    ).catchError(
      (error) {
        emit(SocialCreateNewPostErrorStates());
      },
    );
  }

  void removeImagePost() {
    createNewPost = null;
    emit(SocialRemoveImagePostErrorStates());
  }

  List<CreatePostModel> postModelAdd = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPost() {
    emit(SocialGetPostLoadingStates());
    FirebaseFirestore.instance.collection('post').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then(
          (value) {
            postModelAdd.add(CreatePostModel.fromJson(element.data()));
            likes.add(value.docs.length);
            postsId.add(element.id);
          },
        ).catchError(
          (error) {},
        );
      }
      emit(SocialGetPostSuccessStates());
    }).catchError(
      (error) {
        print('error << $error >>');
        emit(SocialGetPostErrorStates());
      },
    );
  }

  void getLikePost({required String postId}) {
    emit(SocialGetPostLoadingStates());
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true}).then((value) {
      emit(SocialGetPostSuccessStates());
    }).catchError(
      (error) {
        emit(SocialGetPostErrorStates());
      },
    );
  }

  void getCommentPost({
    required String uIdComment,
    required String textComment,
    String? imageComment,
    String? postId,
  }) {
    emit(SocialGetCommentLoadingStates());

    CommentModel commentModel = CommentModel(
      name: model!.name,
      textComment: textComment,
      image: model!.image,
      uId: model!.uId,
      imageComment: imageComment,
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection('post')
        .doc(uIdComment)
        .collection('comments')
        .doc(model!.uId)
        .set(commentModel.toMapComment())
        .then((value) {
      emit(SocialGetCommentSuccessStates());
    }).catchError(
      (error) {
        emit(SocialGetCommentErrorStates());
      },
    );
  }

  File? createCommentImage;
  final ImagePicker createCommentPicker = ImagePicker();

  Future<void> getCommentImage() async {
    final pickedFileCover = await createCommentPicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFileCover != null) {
      createCommentImage = File(pickedFileCover.path);
      emit(SocialCreateCommentImageSuccessStates());
    } else {
      print('Error in image');
      emit(SocialCreateCommentImageErrorStates());
    }
  }

  void uploadCommentImage(
      {required String textComment,
      required String uIdComment,
      String? imageComment,
      String? postId}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'Comments/${Uri.file(createCommentImage!.path).pathSegments.last}')
        .putFile(createCommentImage!)
        .then((value) {
      print(value);
      value.ref.getDownloadURL().then(
        (value) {
          getCommentPost(
            uIdComment: uIdComment,
            textComment: textComment,
            imageComment: value,
            postId: postId,
          );
          emit(SocialUploadCommentCoverImageSuccessStates());
        },
      ).catchError(
        (error) {
          emit(SocialUploadCommentImageErrorStates());
        },
      );
    }).catchError(
      (error) {
        print(error.toString());
        emit(SocialUploadCommentImageErrorStates());
      },
    );
  }

  List<CommentModel> commentModelAdd = [];
  List<String> postsIdCom = [];
  List<int> comment = [];

  void getComment() {
    emit(SocialGetCommentLoadingStates());
    FirebaseFirestore.instance.collection('post').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('comments').snapshots().listen((event) {
          comment.add(event.docs.length);
          postsIdCom.add(element.id);
          for (var values in event.docs) {
            commentModelAdd.add(CommentModel.fromJson(values.data()));
            print(values.data());
          }
        });
      }
      emit(SocialGetCommentSuccessStates());
    }).catchError(
      (error) {
        print('error << $error >>');
        emit(SocialGetCommentErrorStates());
      },
    );
  }

  List<SocialUserModel>? allUsers = [];

  void getAllUsers() {
    allUsers = [];
    emit(SocialGetAllUserLoadingStates());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (model!.uId != element.data()['uId'])
          allUsers!.add(SocialUserModel.fromJson(element.data()));
      }
      emit(SocialGetAllUserSuccessStates());
    }).catchError(
      (error) {
        print(error.toString());
        emit(SocialGetAllUserErrorStates());
      },
    );
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dataTime,
  }) {
    MessageModel messageModel = MessageModel(
      receiverId: receiverId,
      senderIn: model!.uId,
      text: text,
      dataTime: dataTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMapMessage())
        .then(
      (value) {
        emit(SocialSendMessageSuccessStates());
      },
    ).catchError(
      (error) {
        emit(SocialSendMessageErrorStates());
      },
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('message')
        .add(messageModel.toMapMessage())
        .then(
      (value) {
        emit(SocialSendMessageSuccessStates());
      },
    ).catchError(
      (error) {
        emit(SocialSendMessageErrorStates());
      },
    );
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        // print(messages.toList());
      });
      emit(SocialGetMessageSuccessStates());
    });
  }

  //Add Friends request

  bool pending = false;

  void pendingFriend({
    required String receiverId,
    required String dataTime,
    String? imageComment,
    required String name,
    required String image,
  }) {
    SendRequestFriend sendRequestFriend = SendRequestFriend(
        receiverId: receiverId,
        senderIn: model!.uId,
        dataTime: dataTime,
        name: name,
        image: image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('pendingFriends')
        .doc(receiverId)
        .collection('friend')
        .add(sendRequestFriend.toMap())
        .then(
      (value) {
        pending = true;
        emit(SocialSendMessageSuccessStates());
      },
    ).catchError(
      (error) {
        emit(SocialSendMessageErrorStates());
      },
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('confirmedFriends')
        .doc(receiverId)
        .collection('friend')
        .add(sendRequestFriend.toMap())
        .then(
      (value) {
        emit(SocialSendMessageSuccessStates());
      },
    ).catchError(
      (error) {
        emit(SocialSendMessageErrorStates());
      },
    );
  }


  List<SendRequestFriend> not = [];

  void getRequestNot() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('confirmedFriends')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      not = [];
      event.docs.forEach((element) {
        not.add(SendRequestFriend.fromJson(element.data()));
        // print(messages.toList());
      });
      emit(SocialGetNotificationSuccessStates());
    });
  }
}
