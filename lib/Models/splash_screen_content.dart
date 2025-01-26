class SplashScreenContent {
  String image;
  String title;
  String description;

  SplashScreenContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<SplashScreenContent> contents = [
  SplashScreenContent(
    title: '100% Safe and Secured',
    image: 'assets/images/safe.svg',
    description: "Surf the web without fear! Our VPN provides robust encryption to guarantee your privacy and security.",
  ),
  SplashScreenContent(
    title: 'Up to 3 Times Faster',
    image: 'assets/images/fastloading.svg',
    description: "Download, stream, and surf with breakneck speed! Our VPN accelerates your connection like never before.",
  ),
  SplashScreenContent(
    title: 'High-Speed Server',
    image: 'assets/images/speed.svg',
    description: "Enjoy seamless connectivity with our high-speed servers optimized for top performance.",
  ),
];