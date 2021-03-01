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
  "title": [
//meta tag
    ":title",
    "description",
    ":description",

/////item prop
    "name",
    "pdp_h1",

    //class
    "product-name",
    "product-description__name",
    "__name",
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
    "product-title",
    "hero-info-title",
  ],
  "image": [
    //meta tag
    ":image:",
    //class
    "image_src",
    "popup-img"
        "product-gallery__image ng-scope",
    "product-image",
    "item active",
    "product-title",
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
    "pimages__image pimages__image--image pimages__image--1 pimages__image--active",

    //id
    "imgProduct",
    "FeaturedImage",
    "amp-originalImage",
//data-test
    "image",
  ]
};

const filters = [
  "property",
  "itemprop",
  "item-prop",
  "class",
  "id",
  "data-test-element",
  "data-test-id"
];
List<String> dataSet = [];
setData(_data) {
  dataSet.add(_data);
}

List<String> getPrice(String domData) {
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
          }
        }
      });
    });
  });

  print('price data 🚀🚀  ${dataSet[0]}  ${dataSet[1]} ${dataSet[2]}');
  var currentCurrency = null;
  var s = [
    "USD",
    "\$",
  ];

  s.forEach((currency) {
    dataSet.forEach((sign) {
      print('----------in-------------');
      if (currentCurrency == null) {
        if (sign.contains(currency)) {
          currentCurrency = currency;
          print('----------currency-------------');
          print(currentCurrency);
        }
      }
    });
  });
  return dataSet;
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

  print('title== 🚀🚀 ${titleSet.toString()}');
  print('title== 🚀🚀 ${titleSet.length}');
  return titleSet;
}

List<String> imageSet = [];
setImage(_data) {
  imageSet.add(_data);
}

List<String> getImage(String domData) {
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['image'].forEach((attrValue) {
    filters.forEach((filter) {
      // print('[$filter*="$attrValue"]');

      var _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

      _data.forEach((Element element) {
        if (filter.contains("prop")) {
          if (element.attributes['content'] != null) {
            if (element.attributes['content'].trim().isNotEmpty) {
              var prop = element.attributes['content'].replaceAll(" ", "");
              print('------runtime type------');
              print(prop.indexOf('http'));

              if (prop.contains('http')) setImage(prop);
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            var data = element.innerText.replaceAll(" ", "");
            print('------runtime type------');

            if (data.contains('http')) setImage(data);
          }
        }
      });
    });
  });

  print('images== 🚀🚀 ${imageSet.toString()}');
  print('images== 🚀🚀 ${imageSet.length}');
  return imageSet;
}
