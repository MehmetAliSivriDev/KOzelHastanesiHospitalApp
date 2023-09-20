enum ImagePaths {
  logo,
  bakanlikLogo,
  hastaLogo,
  uzmanlaraSorunDoktor,
  randevuDoktorlar
}

extension ImagePathsExtension on ImagePaths {
  String getLogoPaths() {
    return "assets/logos/$name.png";
  }

  String getImgPaths() {
    return "assets/img/$name.png";
  }
}
