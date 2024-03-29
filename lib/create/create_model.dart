import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/domain/post.dart';

class CreateModel {
  final _picker = ImagePicker();

  Future<File?> getImage() async {
    //이미지피커를 사용해서 이미지를 선택한다
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    return File(image.path);
    //path = 이미지가 생성되는 경로, path는 null값을 안받기때문에 nullable로 바꿔줘야됨
  }

  Future<void> uploadPost(String title, File imageFile) async {
    //이미지 업로드
    //flutterfire > Cloud storage > upload files
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef
        .child('postImages/${DateTime.now().millisecondsSinceEpoch}.png');

    //이미지 url을 얻고
    await imageRef.putFile(imageFile);
    final downloadUrl = await imageRef.getDownloadURL();

    //게시물 업로드

    //게시물 (포스트) 업로드하기위해 제목과 이미지파일을 받아오는 메소드
    //firestore_cloud 라이브러리를 추가
    //flutterfire > Cloud Firestore > usage > Writing Data에 있는 메소드 복붙
    //FirebaseFirestore.instance > 데이터베이스 접근
    //collection > DB안에 있는 데이터
    //withConverter<Post> Post 데이터로 변환을 할거다
    //가지고 올때는 이 구문을 통해 Post.fromJson(snapshot.data()!) Post로 변환하고
    //firestore에 쓸때는 json형태로 만들어준다 post.toJson()
    final postsRef =
        FirebaseFirestore.instance.collection('posts').withConverter<Post>(
              fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
              toFirestore: (post, _) => post.toJson(),
            );
    final newPostref = postsRef.doc();
    //문서를 생성하지않아도 새로운 문서의 주소를 미리 만들어볼수있다

    newPostref.set(
      Post(
        id: newPostref.id, //사전에 문서의 id를 얻어옴(문서 삭제기능을 위해)
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        //currentUser?.uid 커런트유저는 null일수있다, uid가 null일때 공백을 준다
        //커런트유저가 널이 아니면 uid을 리턴하고 어느쪽도 null이면 기본값으로 공백을준다.
        title: title,
        imageUrl: downloadUrl,
      ),
    );
  }
}
