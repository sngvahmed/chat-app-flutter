class PublicChannelMsg {
  final String msg;
  final String name;

  const PublicChannelMsg(this.name, this.msg);
   Map<String, dynamic> toJson() =>
  {
    'name': name,
    'msg': msg,
  };
}
