bool isHttpOK(int statusCode) {
  return statusCode == 201 || statusCode == 202 ? true : false;
}
