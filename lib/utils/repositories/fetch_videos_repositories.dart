import 'package:gracetech_task/controllers/data_controllers/fetch_videos_controller.dart';
import 'package:gracetech_task/models/movies_model.dart';
import 'package:gracetech_task/utils/api_manager.dart';
import 'package:http/http.dart' as http;

class FetchVideosRepo {
  static Future<int> fetchVideos() async {
    var res = await http.Client().read(Uri.parse(ApiManager.videosUrl));
    // to remove the raw text and extract pure json response
    var json = res.split("=").last.replaceAll(";", "").trim();

    //parse the json to Model and assign the model to static controller
    FetchVideosController.controller = MoviesModel.fromRawJson(json);
    return 200;
  }
}
