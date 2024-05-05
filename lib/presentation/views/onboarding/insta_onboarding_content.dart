class InstaOnboardingContents {
  final String title;
  final String image;
  final String desc;

  InstaOnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<InstaOnboardingContents> contents = [
  // InstaOnboardingContents(
  //   title: "Welcome to InstaKing!",
  //   image: "assets/images/insta-king-welcome.png",
  //   desc:
  //       "Connect with real people who share your interests. Our platform focuses on authentic connections and organic growth.   ",
  // ),
  InstaOnboardingContents(
    title: "Most Reliable Platform for VTU", //SMM not  VTU
    image: "assets/images/insta-01.png",
    desc:
        "Instaking has proven to be the best Bill Payment platform in Africa and beyond.", //SMM platform, not Bill Payment
  ),
  // InstaOnboardingContents(
  //   title: "Engage Authentically",
  //   image: "assets/images/insta-king-engage.png",
  //   desc:
  //       "Engage with your audience in a meaningful way. Foster genuine interactions, discussions, and build a community around your passion.",
  // ),
  InstaOnboardingContents(
    title: "All VTU Services at your fingertips", //VTU keh? SMM werey
    image: "assets/images/insta-02.png",
    desc: "We offer a wide range of services for all platforms",
  ),
];
