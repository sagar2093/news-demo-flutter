class Article {
    String? author;
    String? content;
    String? description;
    String? publishedAt;
    String? title;
    String? url;
    String? urlToImage;

    Article({this.author, this.content, this.description, this.publishedAt, this.title, this.url, this.urlToImage});

    factory Article.fromJson(Map<String, dynamic> json) {
        return Article(
            author: json['author'], 
            content: json['content'], 
            description: json['description'], 
            publishedAt: json['publishedAt'], 
            title: json['title'], 
            url: json['url'], 
            urlToImage: json['urlToImage'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author'] = this.author;
        data['content'] = this.content;
        data['description'] = this.description;
        data['publishedAt'] = this.publishedAt;
        data['title'] = this.title;
        data['url'] = this.url;
        data['urlToImage'] = this.urlToImage;
        return data;
    }
}