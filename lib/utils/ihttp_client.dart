abstract class IHttpClient {
  Future<String> get(String url);
}