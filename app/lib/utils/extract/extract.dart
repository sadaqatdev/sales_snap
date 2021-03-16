import 'dart:math';

import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/utils/extract/extractor-contstants.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

class Extractor {
  // Map<String, String> getPrices(String body) {
  //   return {"currency": "USD", "amount": "${Random().nextDouble()}"};
  // }

  /// @callback (List<String> titles)
  getTitles(String dom, Function callback) {
    List<String> titles = [];
    HtmlDocument document = parseHtmlDocument(dom);
    Selectors.titlesQueries.forEach((String query) {
      List<Element> elements = document.querySelectorAll(query);

      if (query.contains("property*=") ||
          query.contains("name=") ||
          query.contains("name*=") ||
          query.contains("itemprop=") ||
          query.contains("itemprop*=")) {
        elements.forEach((Element element) {
          titles.add(element.attributes['content']);
        });
      }
      if (titles.length == 0) {
        elements.forEach((Element element) {
          titles.add(element.innerText);
        });
      }
    });
    callback(titles);
  }

  /// @callback (List<String> images)
  getImages(String dom, Function callback, String url) {
    String host = Uri.parse(url).host;
    List<String> images = [];
    HtmlDocument document = parseHtmlDocument(dom);
    Selectors.imagesQueries.forEach((String query) {
      List<Element> elements =
          document.querySelectorAll(query.trimRight().trimLeft());
      if (query.contains("property=") ||
          query.contains("name=") ||
          query.contains("name*=") ||
          query.contains("itemprop=") ||
          query.contains("itemprop*=")) {
        elements.forEach((Element element) {
          if (element.attributes['content'] != null) {
            if (element.attributes['content'].indexOf("//") == 0) {
              if (!element.attributes['content'].contains(".svg")) {
                images.add("https:${element.attributes['content']}");
              }
              return;
            }
            if (element.attributes['content'].indexOf("/") == 0) {
              if (!element.attributes['content'].contains(".svg")) {
                images.add("https://$host${element.attributes['content']}");
              }
              return;
            }
            images.add(element.attributes['content']);
          }
        });
      }
      if (images.length == 0) {
        elements.forEach((Element element) {
          if (images.length > 0) {
            return;
          }
          if (element.attributes['src'] != null) {
            if (element.attributes['src'].isNotEmpty) {
              if (element.attributes['src'].indexOf("//") == 0) {
                if (!element.attributes['src'].contains(".svg")) {
                  images.add("https:${element.attributes['src']}");
                }
                return;
              }
              if (element.attributes['src'].indexOf("/") == 0) {
                if (!element.attributes['src'].contains(".svg")) {
                  images.add("https://$host${element.attributes['src']}");
                }
                return;
              }
              // print(
              //     "elements at lin 73 extract.dart ${element.attributes.toString()}");
              if (!element.attributes['src'].contains(".svg")) {
                images.add("${element.attributes['src']}");
              }
            }
          }
        });
      }
    });
    callback(images);
  }

  /// @callback (List<String> prices)
  getPrices(String dom, Function callback, String url) {
    List<String> prices = [];

    List<Map<String, dynamic>> priceElements = [];

    HtmlDocument document = parseHtmlDocument(dom);

    Selectors.pricesQueries.forEach((String query) {
      List<Element> elements =
          document.querySelectorAll(query.trimRight().trimLeft());

      if (query.contains("property=") ||
          query.contains("name=") ||
          query.contains("name*=") ||
          query.contains("itemprop=") ||
          query.contains("itemprop*=")) {
        elements.forEach((Element element) {
          if (element.attributes['content'] != null) {
            priceElements.add({"$query": element});

            prices.add(element.attributes['content']);

            print(
                "line 115 💎 element $element price ${element.attributes['content']}");
          }
        });
      }
      if (prices.length == 0) {
        elements.forEach((Element element) {
          if (prices.length > 0) {
            return;
          }
          priceElements.add({"$query": element});
          prices.add(element.innerText);
        });
      }
    });

    callback(prices, priceElements);
  }

  /// @callback (String currency)
  getCurrency(String dom) {
    String currency = "";
    HtmlDocument document = parseHtmlDocument(dom);
    Selectors.currencyQueries.forEach((String query) {
      List<Element> elements =
          document.querySelectorAll(query.trimRight().trimLeft());
      if (query.contains("property=") ||
          query.contains("name=") ||
          query.contains("name*=") ||
          query.contains("itemprop=") ||
          query.contains("itemprop*=")) {
        elements.forEach((Element element) {
          if (element.attributes['content'] != null) {
            currency = element.attributes['content'];
            // print(
            //     "line 115 💎 element $element price ${element.attributes['content']}");
          }
        });
      }
    });
    return currency;
  }
}
