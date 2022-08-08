bool isHttpOK(int statusCode) {
  return statusCode == 200 || statusCode == 201 || statusCode == 202 ? true : false;
}
