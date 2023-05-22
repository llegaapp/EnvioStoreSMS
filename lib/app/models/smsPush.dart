class SmsPush {
  int? id;
  String? phone;
  String? name;
  String? message;
  String? date;
  int? send = 0;
  bool visible = true;

  SmsPush({this.id, this.phone, this.name, this.message, this.date, this.send});

  factory SmsPush.Copy(SmsPush o) {
    return SmsPush(
      id: o.id,
      phone: o.phone,
      name: o.name,
      message: o.message,
      date: o.date,
      send: o.send,
    );
  }

  get isEmpty => null;
  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name,
      'message': message,
      'date': date,
      'send': send
    };
  }

  String toString() {
    return 'SmsPush(  id: $id,\n '
            'phone: $phone,\n  ' +
        'name: $name,\n  ' +
        'message: $message,\n  ' +
        'date: $date,\n  ' +
        'sent: $send,\n  ' +
        'visible: $visible,\n  ' +
        ',)\n )\n';
  }
}
