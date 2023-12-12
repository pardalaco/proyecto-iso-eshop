// ignore_for_file: file_names

class Tags {
  late List<Tag> tags;

  Tags.fromJson(Map<String, dynamic> json, bool fromProduct) {
    tags = <Tag>[];
    var a = json['tags'];
    if (fromProduct) {
      a = a.split(",");
    }
    a.forEach((v) {
      tags.add(Tag.fromJson(v, false));
    });
  }

  @override
  String toString() {
    String rv = "";
    for (Tag t in tags) {
      rv += "${t.name},";
    }
    return rv.substring(0, rv.length - 1);
  }
}

class Tag {
  late String name;
  late bool choose;
  Tag.fromJson(this.name, this.choose);
}
