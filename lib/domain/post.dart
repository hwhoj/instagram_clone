class Post {
  String id;
  String? userId;
  //얘 왜 널값받아옴?
  String title;
  String imageUrl;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.imageUrl,
  });

  //데이터를 가져올때
  factory Post.fromJson(Map<String, dynamic> json) {
    //Post.fromJson > 다트문법에서 생성자를 만드는것중에하나. Json으로부터 Post를 만듬
    //(Map<String, dynamic> json) json이라는것은 Map과 동일한 모양을 가지고있다
    //string은 키값, 다이나믹은 밸류값
    //fromJson가 들어간 생성자를 만들때 factory를 붙여준다

    return Post(
      //Post를 만들어서 리턴을 한다
      //json에서 userid 등의 값을 스트링으로 변환해서 가져온다
      id: json['id'] as String,
      userId: json['userId'],
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  //데이터를 DB에 쓸때는 Map<String, dynamic> json 형태로 만들어줘야함
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
