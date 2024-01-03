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
  InstaOnboardingContents(
    title: "Welcome to Insta King!",
    image: "assets/images/insta-king-welcome.png",
    desc:
        "Connect with real people who share your interests. Our platform focuses on authentic connections and organic growth.",
  ),
  InstaOnboardingContents(
    title: "Boost Your Visibility",
    image: "assets/images/insta-king-boost.png",
    desc:
        "Enhance your online presence responsibly. Get more visibility for your content and make meaningful connections with users who genuinely appreciate your work.",
  ),
  InstaOnboardingContents(
    title: "Engage Authentically",
    image: "assets/images/insta-king-engage.png",
    desc:
        "Engage with your audience in a meaningful way. Foster genuine interactions, discussions, and build a community around your passion.",
  ),
  InstaOnboardingContents(
    title: "Understand the Value of Authenticity",
    image: "assets/images/insta-king-auth.png",
    desc:
        "Authenticity matters. Real followers bring real engagement. Building a genuine audience ensures lasting connections and credibility..",
  ),
];
