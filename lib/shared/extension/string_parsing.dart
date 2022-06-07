import '../config/urls_config.dart';

extension StringParsing on String? {
  String walletAddressSplit() {
    if (this != null && (this?.length ?? 0) > 0) {
      String result = this!.substring(0, 6) +
          "..." +
          this!.substring(this!.length - 4, this!.length);
      return result;
    } else {
      return "wallet address not found";
    }
  }

  String stringHashImageToImageUrl() {
    if (this == null) return "";
    return "https://$this" + UrlsConfig.infuraIPFSClient;
  }

  String stringGweiToWei() {
    if (this == null) return "";
    return (int.parse(this!) * 1000000000).toString();
  }

  String stringSecondsToStringMinutes() {
    if (this == null) return "";
    int seconds = int.parse(this!);
    int minutes = seconds ~/ 60;
    int secondsLeft = seconds % 60;
    return "$minutes mins: $secondsLeft secs";
  }

  String removeCharacteres() {
    if (this == null) return "";
    
    return this!.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  String removeComa() {
    if (this == null) return "";

    return this!.replaceAll(',', '');
  }
}
