<<<<<<< Updated upstream
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

const productAttributeMap = {
  "price": [
    ":price:amount",
    ":price:currency",
    "priceCurrency",
    "price",
    "product-main ProductPriceBlock__Price",
    "priceblock_dealprice",
    "PriceBlock",
    "current-price",
    "product-price",
    "priceblock",
    "product-price",
    "ProductPrice",
    "PriceBlock",
    "dealprice",
    "__Price",
    "-price",
    "price--",
    "price__",
    "-price",
    "Price",
    "price",
  ],
};

const filters = [
  "property",
  "itemprop",
  "item-prop",
  "class",
  "id",
  "data-test-element",
];
var dataSet = [];
setData(_data) {
  dataSet.add(_data);  
}

getData(String domData) {
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['price'].forEach((attrValue) {
    filters.forEach((filter) {
      // print('[$filter*="$attrValue"]');

      var _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

      _data.forEach((Element element) {
        if (filter.contains("prop")) {
          if (element.attributes['content'] != null) {
            if (element.attributes['content'].trim().isNotEmpty) {
              setData(element.attributes['content'].replaceAll(" ", ""));
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            setData(element.innerText.replaceAll(" ", ""));
=======
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/utils/extract/extract-consts.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

class Extractor {
  List<String> titles = [];
  List<String> images = [];
  List<String> prices = [];
  List<String> getTitle(String domData) {
    titles.clear();
    HtmlDocument document = parseHtmlDocument(domData);
    productAttributeMap['titles'].forEach((String selector) {
      List<Element> elements = document.querySelectorAll(selector);
      elements.forEach((Element element) {
        if (selector.contains("itemprop")) {
          String productTitle = element.innerText;
          if (productTitle != null) {
            if (productTitle.isNotEmpty) titles.add(productTitle);
          }
        } else if (selector.contains("prop")) {
          String productTitle = element.getAttribute('content');
          if (productTitle != null) {
            if (productTitle.isNotEmpty) titles.add(productTitle);
          }
        } else {
          String productTitle = element.innerText;
          if (productTitle != null) {
            if (productTitle.isNotEmpty) titles.add(productTitle);
>>>>>>> Stashed changes
          }
        }
      });
    });
  });

<<<<<<< Updated upstream
  print('data 🚀🚀  ${dataSet[0]}  ${dataSet[1]} ${dataSet[2]}');
=======
    return titles;
  }

  List<String> getImage(String domData) {
    images.clear();
    HtmlDocument document = parseHtmlDocument(domData);
    productAttributeMap['images'].forEach((String selector) {
      List<Element> elements = document.querySelectorAll(selector);
      elements.forEach((Element element) {
        if (selector.contains("itemprop")) {
          String productImage =
              element.attributes['src'] ?? element.attributes['srcset'];
          if (productImage != null) {
            if (productImage.isNotEmpty &&
                (productImage.contains(".jpg") ||
                    productImage.contains(".png"))) images.add(productImage);
          }
        } else if (selector.contains("prop")) {
          String productImage = element.getAttribute('content');
          if (productImage != null) {
            if (productImage.isNotEmpty &&
                (productImage.contains(".jpg") ||
                    productImage.contains(".png"))) images.add(productImage);
          }
        } else {
          String productImage =
              element.attributes['src'] ?? element.attributes['srcset'];
          if (productImage != null) {
            if (productImage.isNotEmpty &&
                (productImage.contains(".jpg") ||
                    productImage.contains(".png"))) images.add(productImage);
          }
        }
      });
    });
    return images;
  }

  Map<String, dynamic> getPrice(String domData) {
    prices.clear();
    final htmlDocument = parseHtmlDocument(domData);

    productAttributeMap['prices'].forEach((attrValue) {
      filters.forEach((filter) {
        // print('[$filter*="$attrValue"]');

        var _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

        _data.forEach((Element element) {
          if (filter.contains("prop")) {
            if (element.attributes['content'] != null) {
              if (element.attributes['content'].trim().isNotEmpty) {
                HomeController.priceHtmlTag = '[$filter*="$attrValue"]';
                print(
                    '==Price==========${element.attributes['content'].replaceAll(" ", "")}');
                prices.add(element.attributes['content'].replaceAll(" ", ""));
              }
            }
          } else if (element.innerText != null) {
            if (element.innerText.trim().isNotEmpty) {
              HomeController.priceHtmlTag = '[$filter*="$attrValue"]';
              print(
                  '==Price==========${element.innerText.replaceAll(" ", "")}');
              prices.add(element.innerText.replaceAll(" ", ""));
            }
          }
        });
      });
    });

    prices = prices.toSet().toList();
    List<String> currencies = ["USD", "£", "EUR", "GBP"];

    String filteredPrice = "";
    String currentCurrency = "";
    prices.forEach((String price) {
      currencies.forEach((String currency) {
        if (filteredPrice.isEmpty) {
          if (price.contains(".")) {
            filteredPrice = price;
          }
        }
        if (currentCurrency.isEmpty) {
          if (price.contains(currency)) {
            currentCurrency = currency;

            if (price.indexOf(currency) < price.indexOf(" "))
              filteredPrice =
                  price.substring(price.indexOf(currency), price.indexOf(" "));
          }
        }
      });
    });

    return {"currency": currentCurrency, "amount": filteredPrice};
  }
>>>>>>> Stashed changes
}

/* <meta property="og:type" content="product">
<meta property="og:title" content="Hornchurch Chelsea Boot">
<meta property="og:image" content="http://cdn.shopify.com/s/files/1/0252/3276/9072/products/hornchurch-chelsea-boot-933092_grande.jpg?v=1583060559">
<meta property="og:image:secure_url" content="https://cdn.shopify.com/s/files/1/0252/3276/9072/products/hornchurch-chelsea-boot-933092_grande.jpg?v=1583060559">
<meta property="og:image" content="http://cdn.shopify.com/s/files/1/0252/3276/9072/products/hornchurch-chelsea-boot-460602_grande.jpg?v=1583060559">
<meta property="og:image:secure_url" content="https://cdn.shopify.com/s/files/1/0252/3276/9072/products/hornchurch-chelsea-boot-460602_grande.jpg?v=1583060559">
<meta property="og:image" content="http://cdn.shopify.com/s/files/1/0252/3276/9072/products/hornchurch-chelsea-boot-484916_grande.jpg?v=1583060559">
<meta property="og:image:secure_url" content="https://cdn.shopify.com/s/files/1/0252/3276/9072/products/hornchurch-chelsea-boot-484916_grande.jpg?v=1583060559">
<meta property="product:price:amount" content="60.00">
<meta property="product:price:currency" content="GBP">
<meta property="og:description" content="Find the Walk London Hornchurch Chelsea Boot in Stone Suede online at Walklondonshoes.co.uk . Free Worldwide Express Delivery &amp; Same Day Dispatch available on Mens Footwear">
<meta property="og:url" content="https://www.walklondonshoes.com/products/hornchurch-chelsea-boot-stone">
<meta property="og:site_name" content="Walk London">
  */
