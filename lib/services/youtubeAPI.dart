import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/YoutubeDataModel.dart';

class YoutubeApi {

  YoutubeApi(this.searchKeyWord) {
    this.url = 'https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=$searchKeyWord&type=video&key=AIzaSyDoSX_HSeOMe8d0l9s-YD61nTqWhv2I9lo';
  }

  final String searchKeyWord;
  String url;

  Future<YoutubeDataModel> getYoutubeVideoData() async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = json.decode(response.body);

    return YoutubeDataModel.fromMap(decode);
  }

}

