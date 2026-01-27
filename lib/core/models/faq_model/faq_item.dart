class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

final faqDemo = <FaqItem>[
  FaqItem(
    question: "What is Zembora and how does it work?",
    answer:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  FaqItem(
    question: "How do I use the app as a guest?",
    answer:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.",
  ),
  FaqItem(
    question: "Can I book ride ?",
    answer:
        "Yes, you can book rides easily using the app once registration is complete.",
  ),
];
