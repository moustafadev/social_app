

class CreatePostModel {
  String? name;
  String? uId;
  String? image;
  String? dataTime;
  String? text;
  String? postImage;

  CreatePostModel({
    this.image,
    this.uId,
    this.text,
    this.name,
    this.dataTime,
    this.postImage,
  });

  CreatePostModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uId = json['uId'];
    text = json['text'];
    image = json['image'];
    dataTime = json['dataTime'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMapPost() {
    return {
      'name': name,
      'text': text,
      'dataTime': dataTime,
      'uId': uId,
      'postImage': postImage,
      'image': image,
    };
  }

}
