

class ChatModel{
  late String to;
  late String from;
  late String msg;
  var  time;

  ChatModel({required this.msg, required this.from, required this.to, required this.time});

  ChatModel.fromJson(dynamic model){
    time = model['time'];
    to = model['to'];
    from = model['from'];
    msg = model['msg'];
  }

  Map<String,dynamic> toJson(){
    return {
      'to': to,
      'from': from,
      'msg': msg,
      'time':time
    };
  }


}