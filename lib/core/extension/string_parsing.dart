extension StringParsing on String? {
  String walletAddressSplit() {
    if (this != null) {
      String result = this!.substring(0, 6) + "..." + this!.substring(this!.length - 4, this!.length);
      return result;
    }
    else {
      return "wallet address not found";
    }
  }
}