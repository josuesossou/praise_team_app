class YoutubeDataModel {
  YoutubeDataModel(
    this.etag,
    this.nextPageToken,
    this.items
  );

  String nextPageToken, etag;
  List<VideoDetail> items;
  
  factory YoutubeDataModel.fromMap(Map data) {
    List<VideoDetail> items = [];
    
    for (var itemData in data['items']) {
      items.add(VideoDetail.fromMap(itemData));
    }
    return YoutubeDataModel(
      data['etag'],
      data['nextPageToken'],
      items,
    );
  } 
}

class VideoDetail {
  VideoDetail(
    this.etag,
    this.videoId,
    this.channelId,
    this.channelTitle,
    this.title,
    this.description,
    this.thumbNail,
  );

  String etag, videoId, channelId, title, description,
          channelTitle;
  Thumbnail thumbNail;

  factory VideoDetail.fromMap(Map data) {
    return VideoDetail(
      data['etag'],
      data['id']['videoId'],
      data['snippet']['channelId'],
      data['snippet']['channelTitle'],
      data['snippet']['title'],
      data['snippet']['description'],
      Thumbnail.fromMap(data['snippet']['thumbnails'])
    );
  }
}

class Thumbnail {
  Thumbnail(
    this.defaultUrl,
    this.defaultH,
    this.defaultW,
    this.mediumUrl,
    this.mediumH,
    this.mediumW
  );

  String defaultUrl, mediumUrl; 
  int defaultW, defaultH, mediumW, mediumH;

  factory Thumbnail.fromMap(Map data) {
    return Thumbnail(
      data['default']['url'],
      data['default']['height'],
      data['default']['width'],
      data['medium']['url'],
      data['medium']['height'],
      data['medium']['width'],
    );
  }
}