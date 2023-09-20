enum LottiePaths { loading }

extension LottiePathsExtension on LottiePaths {
  String getPath() {
    return "assets/lottie/$name.json";
  }
}
