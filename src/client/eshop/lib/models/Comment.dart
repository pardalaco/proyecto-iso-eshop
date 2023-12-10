// ignore_for_file: file_names

class Comments {
  late List<Comment> comments;

  Comments.fromJson(Map<String, dynamic> json) {
    comments = <Comment>[];
    var a = json['ratings'];
    a.forEach((v) {
      comments.add(Comment.fromJson(v));
    });
  }
}

class Comment {
  late String email;
  late String com;
  late double rating;
  late String date;

  Comment.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    com = json['comment'];
    rating = json['rating'].toDouble();
    date = json['date'];
  }
}
