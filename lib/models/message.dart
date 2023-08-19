class MesseageModel {
  final String sendId;
  final String receierId;
  final String dateTime;
  final String text;

  MesseageModel({
    required this.sendId,
    required this.dateTime,
    required this.receierId,
    required this.text,
  });

  factory MesseageModel.fromJson(jsonData) {
    return MesseageModel(
      sendId: jsonData['sendId'],
      dateTime: jsonData['dateTime'],
      receierId: jsonData['receierId'],
      text: jsonData['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sendId': sendId,
      'dateTime': dateTime,
      'receierId': receierId,
      'text': text,
    };
  }
}
