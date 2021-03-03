import 'package:sales_snap/controllers/home_controller.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

const productAttributeMap = {
  "price": [
    ":price:amount",
    ":price:currency",
    "priceCurrency",
    "product-price",
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
  "title": [
//meta tag
    ":title",
    "title",
    "description",
    ":description",

/////item prop
    "name",
    "pdp_h1",

    //class
    "product-name",
    "product-description__name",
    "__name",
    "title",
    "item-name",
    "pdp-title",
    "product-name",
    "product_name",
    "produit_title",
    "product__title",
    "font-primary",
    "short-title",
    "page-title",
    "productName_title",
    "productName",
    "BrandTitle",
    "productBrandTitle",
    "pl-Heading",
    "pdp__heading",
    "title--",
    "page-title",
    "pl-Heading",
    "product-single__title",
    "page-title",
    "product-title",
    "product__title",
    "product-page__title",
    "__title",
    "productName_title",
    "product_title",
    "productName_title",
    "productHeading",
    "product-description",
    "pinfo__heading",
    "listing-page-title",
    "lblProductName",
    "lblProduct",
    "productTitle",
    "itemTitle",
    "title",
    "hero-info-title",
  ],
  "image": [
    //meta tag
    ":image:",
    "image_src",
    {"parent": ".ProductImagery", "child": "img"},
    {"parent": ".image", "child": "img"},
    {"parent": ".product-image", "child": "img"},
    {"parent": ".product-gallery", "child": "img"},
    "popup-img",
    "product-image",
    "item active",
    "imgTagWrapper",

    "b-product_images-main_image",
    "swiper-zoom-container",
    "mb-3 long-description",
    "ProductImages-imgLink",
    "pdp-slider",
    "product-image",
    "ProductImage-",
    "img-responsive product__image"
        "product-image",
    "productImages-",
    "slick-slide",
    "zoomImgMask",
    " ls-is-cached lazyloaded",
    "product-image-zoom",
    "productpage-image",
    "productImageCarousel_image",
    "athenaProductImageCarousel_image",
    "productBrandTitle",
    "js-big-image",
    "product-gallery-image",
    "image-wrapper",
    "s7staticimage",
    "ProductImage",
    "sticker",
    "pl-FluidImage-image",
    "img-wrap",
    "zoomImg",
    "product-carousel-image",
    "main-image",
    "productImageCarousel_image",
    "image_item",
    "SGBOXU1_image",
    "amp-page",
    "slick-slide",
    "slick-slide slick-current slick-active",
    "pimages",
    //id
    "imgProduct",
    "FeaturedImage",
    "imgTagWrapperId",
    "amp-originalImage",
//data-test
    "image",
  ]
};

const filters = [
  "property",
  "class",
  "itemprop",
  "item-prop",
  "id",
  "data-test-element",
  "data-test-id"
];
List<String> dataSet = [];
setData(_data) {
  dataSet.add(_data);
}

Map<String, dynamic> getPrice(String domData) {
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['price'].forEach((attrValue) {
    filters.forEach((filter) {
      // print('[$filter*="$attrValue"]');

      var _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

      _data.forEach((Element element) {
        if (filter.contains("prop")) {
          if (element.attributes['content'] != null) {
            if (element.attributes['content'].trim().isNotEmpty) {
              HomeController.priceHtmlTag = '[$filter*="$attrValue"]';
              setData(element.attributes['content'].replaceAll(" ", ""));
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            HomeController.priceHtmlTag = '[$filter*="$attrValue"]';
            setData(element.innerText.replaceAll(" ", ""));
          }
        }
      });
    });
  });

  var currentCurrency = "";
  var s = ["USD", "\$", "£", "PKR"];

  dataSet.forEach((sign) {
    s.forEach((currency) {
      if (currentCurrency.isEmpty) {
        if (sign.contains(currency)) {
          currentCurrency = currency;
        }
      }
    });
  });

  dataSet = dataSet.toSet().toList();
  var newDataSet = [];
  dataSet.forEach((e) {
    if (e != currentCurrency) {
      newDataSet.add(e);
    }
  });

  return {"currency": currentCurrency, "amount": newDataSet[0]};
}

List<String> titleSet = [];
setTitle(_data) {
  titleSet.add(_data);
}

List<String> getTitle(String domData) {
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['title'].forEach((attrValue) {
    filters.forEach((filter) {
      // print('[$filter*="$attrValue"]');

      var _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

      _data.forEach((Element element) {
        if (filter.contains("prop")) {
          if (element.attributes['content'] != null) {
            if (element.attributes['content'].trim().isNotEmpty) {
              setTitle(element.attributes['content'].replaceAll(" ", ""));
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            setTitle(element.innerText.replaceAll(" ", ""));
          }
        }
      });
    });
  });

  return titleSet.toSet().toList();
}

List<String> imageSet = [];
setImage(_data) {
  imageSet.add(_data);
}

List<String> getImage(String domData) {
  imageSet = [];
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['image'].forEach((dynamic attrValue) {
    filters.forEach((filter) {
      var _data;
      if (attrValue.runtimeType.toString().contains("Map")) {
        _data = htmlDocument
            .querySelectorAll("${attrValue['parent']} ${attrValue['child']}");
      } else {
        _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

        _data.forEach((Element element) {
          if (filter.contains("prop")) {
            if (element.attributes['content'] != null) {
              if (element.attributes['content'].trim().isNotEmpty) {
                String prop = element.attributes['content'].replaceAll(" ", "");

                if (prop.contains('http')) setImage(prop);
              }
            }
          } else if (element.innerText != null) {
            if (element.innerText.trim().isNotEmpty) {
              String data = element.innerText.replaceAll(" ", "");

              if (data.contains('http')) setImage(data);
            }
          }
        });
      }
    });
  });

  return imageSet.toSet().toList();
}
