// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String body;
  final DateTime timeDelivered;
  MessageModel({
    required this.body,
    required this.timeDelivered,
  });

  MessageModel copyWith({
    String? body,
    DateTime? timeDelivered,
  }) {
    return MessageModel(
      body: body ?? this.body,
      timeDelivered: timeDelivered ?? this.timeDelivered,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'timeDelivered': timeDelivered.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      body: map['body'] as String,
      timeDelivered:
          DateTime.fromMillisecondsSinceEpoch(map['timeDelivered'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageModel(body: $body, timeDelivered: $timeDelivered)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.body == body && other.timeDelivered == timeDelivered;
  }

  @override
  int get hashCode => body.hashCode ^ timeDelivered.hashCode;
}
