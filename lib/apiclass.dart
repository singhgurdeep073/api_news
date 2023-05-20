class News{
  final String title;
  final String url;
  News({required this.title,required this.url});

  factory News.FromJson(Map<String,dynamic>json){
    return News(title: json['status'],url: json['source']);


  }


}