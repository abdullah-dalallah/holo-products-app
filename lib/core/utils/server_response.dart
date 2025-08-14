class ServerResponse {
  bool getSuccessOrFailed(int statusCode) {
    switch (statusCode) {
      case 200:
        return true;

      case 201:
        return true;

      case 401:
        return true;
      case 422:
        return true;
      case 403:
        return false;

      case 409:
        return false;

      case 413:
        return false;

      case 500:
        return false;

      default:
        return false;
    }
  }
}
