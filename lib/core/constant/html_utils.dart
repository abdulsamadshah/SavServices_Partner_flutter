import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

String sanitizeHtml(String htmlContent) {
  final document = html_parser.parse(htmlContent);

  document.querySelectorAll('h1, h2, h3, h4, h5, h6').forEach((element) {
    final pTag = dom.Element.tag('p')..innerHtml = element.innerHtml;

    element.replaceWith(pTag);
  });

  return document.body?.innerHtml ?? '';
}
