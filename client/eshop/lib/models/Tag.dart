// ignore_for_file: file_names, non_constant_identifier_names

class Tags {
  late List<Tag> tags;

  Tags.fromJson(Map<String, dynamic> json, bool fromProduct) {
    tags = <Tag>[];
    var a = json['tags'];
    if (fromProduct) {
      a = a?.isEmpty ?? true ? [] : a.split(",");
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
    return rv.isNotEmpty ? rv.substring(0, rv.length - 1) : "";
  }

  String onlyTrues() {
    String rv = "";
    for (Tag t in tags) {
      if (t.choose) {
        rv += "${t.name},";
      }
    }
    return rv.isNotEmpty ? rv.substring(0, rv.length - 1) : "";
  }

  void intersectionToTrue(Tags p_tags) {
    late int index;
    for (Tag t in p_tags.tags) {
      if ((index = tags.indexOf(t)) != -1) {
        tags[index].choose = true;
      }
    }
  }
}

class Tag {
  late String name;
  late bool choose;

  Tag.fromJson(this.name, this.choose);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Tag && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
