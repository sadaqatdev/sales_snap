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
    ":image",

    /////item prop
    "image",
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
          }
        }
      });
    });
  });

  print('data 🚀🚀  ${dataSet[0]}  ${dataSet[1]} ${dataSet[2]}');
}

var titleSet = [];
setTitle(_data) {
  titleSet.add(_data);
}

getTitle(String domData) {
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
}

var imageSet = [];
setImage(_data) {
  imageSet.add(_data);
}

getImage(String domData) {
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['image'].forEach((attrValue) {
    filters.forEach((filter) {
      // print('[$filter*="$attrValue"]');

      var _data = htmlDocument.querySelectorAll('[$filter*="$attrValue"]');

      _data.forEach((Element element) {
        if (filter.contains("prop")) {
          if (element.attributes['content'] != null) {
            if (element.attributes['content'].trim().isNotEmpty) {
              setImage(element.attributes['content'].replaceAll(" ", ""));
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            setImage(element.innerText.replaceAll(" ", ""));
          }
        }
      });
    });
  });

  print('title== 🚀🚀 ${imageSet.toString()}');
  print('title== 🚀🚀 ${imageSet.length}');
}
