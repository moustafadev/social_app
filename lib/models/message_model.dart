

class MessageModel {
  String? text;
  String? dataTime;
  String? senderIn;
  String? receiverId;

  MessageModel({
    this.dataTime,
    this.senderIn,
    this.text,
    this.receiverId,
  });

  MessageModel.fromJson(Map<String, dynamic> json){
    senderIn = json['senderIn'];
    receiverId = json['receiverId'];
    text = json['text'];
    dataTime = json['dataTime'];
  }

  Map<String, dynamic> toMapMessage() {
    return {
      'senderIn': senderIn,
      'text': text,
      'dataTime': dataTime,
      'receiverId': receiverId,
    };
  }

}
