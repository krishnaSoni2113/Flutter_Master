import 'package:http/http.dart' as http;
import 'MasterConstant.dart';



var BASEURL = "https://itrainacademy.in/nerd/api/v1/";
Map<String, String> headers = new Map();

const CStatusZero = 0;
const CStatusOne = 1;
const CStatusTwo = 2;
const CStatusThree = 3;
const CStatusFour = 4;
const CStatusFive = 5;
const CStatusEight = 8;
const CStatusNine = 9;
const CStatusTen = 10;
const CStatusEleven = 11;

const CStatus200 = 200; // Success
const CStatus400 = 400;
const CStatus401 = 401; // Unauthorized
const CStatus403 = 403; // Unauthorized
const CStatus405 = 405; // User Deleted
const CStatus500 = 500;
const CStatus550 = 550; // Inactive/Delete user
const CStatus555 = 555; // Invalid request
const CStatus556 = 556; // Invalid request



class APIRequest {
  static final APIRequest shared = new APIRequest._internal();

  factory APIRequest() {
    return shared;
  }

  APIRequest._internal();

  /* ----------------------- HEADERS----------------------- */
  Map apiHeaders() {
    headers = {"Accept": "application/json"};
    return headers;
  }

  /* ----------------------- APIS METHODS----------------------- */

  Future<http.Response> _POST(String apiTag, Map<String, String> para,
      Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      return http
          .post(BASEURL + apiTag, body: para, headers: finalHeaders)
          .then((http.Response response) {
        return response;
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }

  Future<http.Response> _POSTMEDIA(String apiTag, Map<String, String> para,
      File imageFile, Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var request =
          new http.MultipartRequest("POST", Uri.parse(BASEURL + apiTag));

      // multipart that takes file
      var multipartFile = new http.MultipartFile('profile_pic', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.fields.addAll(para);
      request.files.add(multipartFile);
      request.headers.addAll(finalHeaders);

      return request.send().then((response) {
        return http.Response.fromStream(response);
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }

  Future<http.Response> _GET(
      String apiTag, Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      String url = BASEURL + apiTag;

      return http
          .get(url, headers: finalHeaders)
          .then((http.Response response) {
        return response;
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }

  Future<http.Response> _PUT(String apiTag, Map<String, String> para,
      Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      return http
          .put(BASEURL + apiTag, body: para, headers: finalHeaders)
          .then((http.Response response) {
        return response;
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }


  Future<http.Response> _HEAD(String apiTag, Map<String, String> para,
      Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      String url = BASEURL + apiTag;

      return http
          .head(url, headers: finalHeaders)
          .then((http.Response response) {
        return response;
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }

  Future<http.Response> _PATCH(String apiTag, Map<String, String> para,
      Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      return http
          .patch(BASEURL + apiTag, body: para, headers: finalHeaders)
          .then((http.Response response) {
        return response;
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }

  Future<http.Response> _DELETE(
      String apiTag, Map<String, String> internalHeaders) async {
    Map<String, String> finalHeaders = new Map();
    finalHeaders.addAll(apiHeaders());
    finalHeaders.addAll(internalHeaders);

    try {
      String url = BASEURL + apiTag;
      return http
          .delete(url, headers: finalHeaders)
          .then((http.Response response) {
        return response;
      });
    } catch (e) {
      // Handel Error
      return null;
    }
  }

  cancelRunningApiRequest(Future sessionTask) {

    if (sessionTask != null)
    {
      StreamQueue reqQue = StreamQueue(Stream.fromFuture(sessionTask));
      print("reqQue ========== $reqQue");

       reqQue.cancel();
      print("cancel========== ${reqQue.cancel()}");
    }

  }

  bool checkResponseStatusAndShowAlert(String apiTag, http.Response response) {
    // Manage your status here.....

    if (response.statusCode == CStatus200 || json != null) {
      return true;
    }

    return true;
  }

  /* ----------------------- Application Functions ----------------------- */

  Future<http.Response> login() async {

    return _POST(
        "login",
        {
          "email": "tom@mailinator.com",
          "password": "abc123",
          "latitude": "23.055",
          "longitude": "72.549316406200006"
        },
        headers).then((response) {
      return response;
    });
  }

  Future<http.Response> userDetails() async {
    return _GET("user-detail", {
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI4MjlkYWU4MjcxNTBlMjk5ZjJjMTZiNDI1MmNhMGFiMzg3NTg2MDgyODZkNGU2NTQ0Yzc3ZTk2ZmNlNDEzN2U1MmY4ZTgwYTMzODkwYjY4In0.eyJhdWQiOiIzIiwianRpIjoiYjgyOWRhZTgyNzE1MGUyOTlmMmMxNmI0MjUyY2EwYWIzODc1ODYwODI4NmQ0ZTY1NDRjNzdlOTZmY2U0MTM3ZTUyZjhlODBhMzM4OTBiNjgiLCJpYXQiOjE1MzEzODAzMTksIm5iZiI6MTUzMTM4MDMxOSwiZXhwIjoxNTYyOTE2MzE5LCJzdWIiOiI3MyIsInNjb3BlcyI6W119.nu7hpJdYdNYSDYhTt1P24L2w45uctaSD8A4DMhiw_t3a5m9V1ilb92DARCIT4p_Mc3Xz6xdDyZqaL8mXtJYZgEZlWSuXMCEgcQWoblBabANmZNqPuIJdAOEymEUtsAiXD-YmJQ4DxwKedzwtnBhDUboRSuSiEHzC0Sl9uoLSeTN8KVEhDT7UjNYW-WC0BmSLkuQWIGHQhQSVQ7sRGFbZwQtX7vSXb6ZUNocUqdC_VspV87_Nxyk11vS9w5W2hF4DjAs8BQAaROAIwZOkhE5GMROXEhIJvNzMgriEf8VJmQoWvIKLOv6rI1niqt71aTmfTNAg2GddyXe5PebtVLJ1L77dHlwY4cPnkGy2mCNkQY26w5zbebIUvIllL9YE_GdtXYAQ4nTYRijE3xJht8J5pauWa3BlwhlaYzEVIa2LQzfUP7gIArL5Q_ULkxq7nKLh7PC51MCyBFtwHDEp25qwP3obK4RvBL3D0lZrRj0-ryGVlMP0Yrit5K_7VggJvkzT8XGW4geDBGZb9FcmQt1RrWnt-24bjNYGIMfQAt78faMGJVNYuZdvcRuA3OAWgCykj7RtRMcDgx2xZ-mvaIllPfgsCzeKwerWo7Sc7gCfh4MDMnV7_5X4FYvb_uad6v3YvNxjxt1B0ZBIUyhHBon8M40J0CCjcn9-Rt9VJWeQqXM"
    }).then((response) {
      final JsonDecoder _decoder = new JsonDecoder();
      print("API  NEW CALLBACK ======= ");
      print(response.request);
      print(response.body);
      print(_decoder.convert(response.body));

      return response;
    });
  }

  Future<http.Response> uploadImage() async {
    File imageFile = new File(
        "/Volumes/Project/FLUTTERPROJETS/flutter_runlive/Images/k.jpg");

    return _POSTMEDIA(
        "save-profile-image",
        {},
        imageFile,
        {
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI4MjlkYWU4MjcxNTBlMjk5ZjJjMTZiNDI1MmNhMGFiMzg3NTg2MDgyODZkNGU2NTQ0Yzc3ZTk2ZmNlNDEzN2U1MmY4ZTgwYTMzODkwYjY4In0.eyJhdWQiOiIzIiwianRpIjoiYjgyOWRhZTgyNzE1MGUyOTlmMmMxNmI0MjUyY2EwYWIzODc1ODYwODI4NmQ0ZTY1NDRjNzdlOTZmY2U0MTM3ZTUyZjhlODBhMzM4OTBiNjgiLCJpYXQiOjE1MzEzODAzMTksIm5iZiI6MTUzMTM4MDMxOSwiZXhwIjoxNTYyOTE2MzE5LCJzdWIiOiI3MyIsInNjb3BlcyI6W119.nu7hpJdYdNYSDYhTt1P24L2w45uctaSD8A4DMhiw_t3a5m9V1ilb92DARCIT4p_Mc3Xz6xdDyZqaL8mXtJYZgEZlWSuXMCEgcQWoblBabANmZNqPuIJdAOEymEUtsAiXD-YmJQ4DxwKedzwtnBhDUboRSuSiEHzC0Sl9uoLSeTN8KVEhDT7UjNYW-WC0BmSLkuQWIGHQhQSVQ7sRGFbZwQtX7vSXb6ZUNocUqdC_VspV87_Nxyk11vS9w5W2hF4DjAs8BQAaROAIwZOkhE5GMROXEhIJvNzMgriEf8VJmQoWvIKLOv6rI1niqt71aTmfTNAg2GddyXe5PebtVLJ1L77dHlwY4cPnkGy2mCNkQY26w5zbebIUvIllL9YE_GdtXYAQ4nTYRijE3xJht8J5pauWa3BlwhlaYzEVIa2LQzfUP7gIArL5Q_ULkxq7nKLh7PC51MCyBFtwHDEp25qwP3obK4RvBL3D0lZrRj0-ryGVlMP0Yrit5K_7VggJvkzT8XGW4geDBGZb9FcmQt1RrWnt-24bjNYGIMfQAt78faMGJVNYuZdvcRuA3OAWgCykj7RtRMcDgx2xZ-mvaIllPfgsCzeKwerWo7Sc7gCfh4MDMnV7_5X4FYvb_uad6v3YvNxjxt1B0ZBIUyhHBon8M40J0CCjcn9-Rt9VJWeQqXM"
        }).then((response) {
      print("IMAGE UPLOAD API ========== ");
      print("CALL BACK ====== ");
      print(response.body);
      print(response.request);
      print(response.headers);

      return response;
    });
  }
} // Class END
