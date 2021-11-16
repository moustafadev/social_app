class SendRequestFriend {
  String? name;
  String? dataTime;
  String? senderIn;
  String? receiverId;
  String? image;

  SendRequestFriend({
    this.dataTime,
    this.senderIn,
    this.name,
    this.receiverId,
    this.image,
  });

  SendRequestFriend.fromJson(Map<String, dynamic> json){
    senderIn = json['senderIn'];
    receiverId = json['receiverId'];
    name = json['name'];
    dataTime = json['dataTime'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderIn': senderIn,
      'name': name,
      'dataTime': dataTime,
      'receiverId': receiverId,
      'image': image,
    };
  }
}