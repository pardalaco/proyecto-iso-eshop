// ignore_for_file: file_names

class Tags {
  late List<Tag> tags;

  Tags.fromJson(Map<String, dynamic> json) {
    tags = <Tag>[];
    var a = json['tags'];
    a.forEach((v) {
      tags.add(Tag.fromJson(v, false));
    });
  }

  @override
  String toString() {
    String rv = "";
    for (Tag t in tags) {
      rv += "${t.name} = ${t.choose.toString()}";
    }
    return rv;
  }
}

class Tag {
  late String name;
  late bool choose;
  Tag.fromJson(this.name, this.choose);
}
