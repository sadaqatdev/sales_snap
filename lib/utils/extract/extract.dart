import 'package:sales_snap/controllers/home_controller.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

const productAttributeMap = {
  "price": [
    "priceCurrency",
    "price",
    ":price:amount",
    "price",
    "-Price-amount",
    "-Price",
    ":price:currency",
    "amount",
    "-title",
    "priceCurrency",
    "product-price",
    "price",
    "nowPrice",
    "product_price",
    "pdp-price",
    "ProductPriceBlock",
    "_price",
    "product_",
    "product-detail",
    "product-main ProductPriceBlock__Price",
    "priceblock_dealprice",
    "PriceBlock",
    "current-price",
    "product-",
    "priceblock",
    "product-",
    "product_",
    "_price",
    "ProductPrice",
    "PriceBlock",
    "dealprice",
    "__Price",
    "product-",
    "-price",
    "price",
    "price--",
    "price__",
    "productImage"
        "-price",
    "Price",
    "price--large",
    "price",
  ],
  "image": [
    // check if map ->
    //  querySelectorAll(‘parent child’)[0]
    /////item prop
    "name",
    "pdp_h1",
    "og:image",
    ":url",

    //classes tags ........
    "image item",
    "image_grid",
    "imageGrid",
    "sale-price",
    "ImageGrid",
    "image",
    ".gallery",
    "pinch-",
    "hinfo",
    "product-",
    "imageBox",
    "Image",
    "-image",
    "primary-",
    "main-image",
    "pdp",
    "pdp-",
    "Image",
    "ImageContainer",
    "image",
    "product-image",
    "product_image",
    "productImage",
    "ProductImage",
    "imgMed",
    "imgProduct",
    "__img",
    "media",
    "imgTag",
    "-image",
    "component-media-gallery",
    "component-media",
    "product-gallery",
    "product-name",
    "product-description__name",
    "productImageCarousel_image",
    "productImageCarousel",
    "imgMed",
    "productCarousel",
    "imgProduct",
    "icImg",
    "product-",
    "product-images",
    "product-view-img",
    "product-view-img",
    "product-view",
    "-display",
    "lblProductName",
    "Product",
    "s7staticimage",
    ////////inner html tages
    "{parent: '.component-media' child:'img',  }",
    "{parent: '.image__container' child:'img',  }",
    "{parent: '.main-page' child:'img',  }",
    "{parent: '.image-viewer' child:'img',  }",
    "{parent: '.image' child:'img',  }",
    "{parent: '.product-detail' child:'img',  }",
    "{parent: '.thumb' child:'img',  }",
    "{parent: '.main-image' child:'img',  }",
    "{parent: '.product-media' child:'img',  }",
    "{parent: '.image-media' child:'img',  }",

    "{parent: '.productName' child:'img',  }",
    "{parent: '.action-sub' child:'img',  }",
    "{parent: '.sub' child:'img',  }",
    "{parent: '.zoomContainer' child:'img',  }",
    "{parent: '.item-img' child:'img',  }",
    "{parent: '.product' child:'img',  }",
    "{parent: '.container' child:'img',  }",
    "{parent: '.image-container' child:'img',  }",
    "{parent: '.-container' child:'img',  }",
    "{parent: '.product-image' child:'img',  }",
    "{parent: '.main-image' child:'img',  }",
    "{parent: '.main' child:'img',  }",
    "{parent: '.-img' child:'img',  }",
    "{parent: '.item' child:'img',  }",
    "{parent: '#item' child:'img',  }",
    "{parent: '.detailApp' child:'img',  }",
    "{parent: '.bimg' child:'img',  }",
    "{parent: '.productpage-image' child:'img',  }",
    "{parent: '.galleryimages-main' child:'img',  }",
    "{parent: '.galleryimages-gallery' child:'img',  }",
    "{parent: '.galleryimages' child:'img',  }",
    "{parent: '.gallery-images' child:'img',  }",
    "{parent: '.gallery_images' child:'img',  }",
    "{parent: '#productpage-image' child:'img',  }",
    "{parent: '.product-main' child:'img',  }",
    "{parent: '#product-main' child:'img',  }",
    "{parent: '.-main' child:'img',  }",
    "{parent: '.product-view-img' child:'img',  }",
    "{parent: '.view-img' child:'img',  }",
    "{parent: '.photo-' child:'img',  }",
    "{parent: '.photo-tour' child:'img',  }",
    "{parent: '.photo' child:'img',  }",
    "{parent: '#photo' child:'img',  }",
    "{parent: '.carousel' child:'img',  }",
    "{parent: '#carousel' child:'img',  }",
    "{parent: '.product' child:'img',  }",
    "{parent: '#product' child:'img',  }",
    "{parent: '.-images' child:'img',  }",
    "{parent: '#-images' child:'img',  }",
    "{parent: '.pinch-' child:'img',  }",
    "{parent: '.product-image' child:'img',  }",
    "{parent: '.product-image' child:'img',  }",
    "{parent: '.pinch' child:'img',  }",
    "{parent: '#pinch-' child:'img',  }",
    "{parent: '._gallery' child:'img',  }",
    "{parent: '._gallery' child:'img',  }",
    "{parent: '#product-intro' child:'img',  }",
    "{parent: '.product_intro' child:'img',  }",
    "{parent: '._intro' child:'img',  }",
    "{parent: '.product-' child:'img',  }",
    "{parent: '.Carousel' child:'img',  }",
    "{parent: '#Carousel' child:'img',  }",
    "{parent: '.productGallery' child:'img',  }",
    "{parent: '#productGallery' child:'img',  }",
    "{parent: '.slide glide__slide' child:'img',  }",
    "{parent: '.slide' child:'img',  }",
    "{parent: '.glide' child:'img',  }",
    "{parent: '#slide glide__slide' child:'img',  }",
    "{parent: '#slide' child:'img',  }",
    "{parent: '#glide' child:'img',  }",
    "{parent: '.swiper-' child:'img',  }",
    "{parent: '.product-' child:'img',  }",
    "{parent: '.sr_image' child:'img',  }",
    "{parent: '.__image' child:'img',  }",
    "{parent: '._image' child:'img',  }",
    "{parent: '.main-image' child:'img',  }",
    "{parent: '.main' child:'img',  }",
    "{parent: '.main shop' child:'img',  }",
    "{parent: '.image-new' child:'img',  }",
    "{parent: '.imageBox' child:'img',  }",
    "{parent: '._images' child:'img',  }",
    "{parent: '.root' child:'img',  }",
    "{parent: '.db_images' child:'img',  }",
    "{parent: '#siteContentcomponent' child:'img',  }",
    "{parent: '.fotorama-' child:'img',  }",
    "{parent: '#fotorama-' child:'img',  }",
    "{parent: '.siteContentcomponent' child:'img',  }",
    "{parent: '.carousel' child:'img',  }",
    "{parent: '.media' child:'img',  }",
    "{parent: '.productCarousel' child:'img',  }",
    "{parent: '.product-gallery' child:'img',  }",
    "{parent: '.product-gallery' child:'img',  }",
    "{parent: '.gallery' child:'img',  }",
    "{parent: '#gallery' child:'img',  }",
    "{parent: '.s7staticimage' child:'img',  }",
    "{parent: '.productImageCarousel' child:'img',  }",
    "{parent: '.product-images' child:'img',  }",
    "{parent: '#product-gallery' child:'img',  }",
    "{parent: '#media' child:'img',  }",
    "{parent: '#productCarousel' child:'img',  }",
    "{parent: '#product-images' child:'img',  }",
    "{parent: '#pdp-gallery' child:'img',  }",
    "{parent: '#s7staticimage' child:'img',  }",
    "{parent: '#productImageCarousel' child:'img',  }",
    "{parent: 'product-' child:'img', }",
    "{parent: 'product-media' child:'img', }",
    "{parent: '.ProductImagery' child:'img',  }",
    "{parent: '.Imagery' child:'img',  }",
    "{parent: '#component-media' child:'img',  }",
    "{parent: '#ProductImagery' child:'img',  }",
    "{parent: '#Imagery' child:'img',  }",
    "{parent: '.image-grid' child:'img',  }",
    "{parent: '.imgTag' child:'img',  }",
    "{parent: '#image-grid' child:'img',  }",
    "{parent: '.image_grid' child:'img',  }",
    "{parent: '#image_grid' child:'img',  }",
    "{parent: 'ImageGrid' child:'img',  }",
    "{parent: '.root' child:'img',  }",
    "{parent: '#ImageGrid' child:'img',  }",
    "{parent: 'imageGrid' child:'img',  }",
    "{parent: '#imageGrid' child:'img',  }",
    "{parent: '.image' child:'img',  }",
    "{parent: '#image' child:'img',  }",
    "{parent: '.Image' child:'img',  }",
    "{parent: '#Image' child:'img',  }",
    "{parent: 'pdp' child:'img',  }",
    "{parent: '.pdp' child:'img',  }",
    "{parent: '#pdp' child:'img',  }",
    "{parent: 'pdp-' child:'img',  }",
    "{parent: '.product-image' child:'img',  }",
    "{parent: '#product-image' child:'img',  }",
    "{parent: '.product_image' child:'img',  }",
    "{parent: '#product_image' child:'img',  }",
    "{parent: '.productImage' child:'img',  }",
    "{parent: '#productImage' child:'img',  }",
    "{parent: '.productImage' child:'img',  }",
    "{parent: '#productImage' child:'img',  }",
    "{parent: '#ProductImage' child:'img',  }",
    "{parent: '#ProductImage' child:'img',  }",
  ],
  "title": [
    ":name",
    "-name",
    "_name",
    "title",
    "-title",
    "productTitle",
    "-name",
    "pdp-title",
    "product-head",
    "product-title",
    "head-name",
    "product-view-title",
    "product-view",
    "main",
    "-title",
    "product-",
    "-title",
    "_Title",
    "product-",
    "page-heading"
        "-detail",
    "product_",
    "-price",
    "content_prices",
    "base",
    "prod-",
    "pdp",
    "price-label",
    "mainPrice"
        "pdp-",
    "product-item",
    "-name",
    "-brand",
    "Description",
    "itemTitle",
    "description",
    "product-header",
    "product_",
    "product-info",
    "price__",
    "__element",
    "product-description",
    "-info",
    "_info",
    "__name",
    "title",
    "page-title",
    "product-detail",
    "Title",
    "item-name",
    "pdp-title",
    "product-name",
    "product-",
    "-sale",
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
    "info-title",
    "hero-info-title",
  ],
};

const filters = [
  "property",
  "name",
  "class",
  "itemprop",
  "item-prop",
  "id",
  "data-test-element",
  "data-test-id",
  "data-test",
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
              print(
                  '==Price==========${element.attributes['content'].replaceAll(" ", "")}');
              setData(element.attributes['content'].replaceAll(" ", ""));
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            HomeController.priceHtmlTag = '[$filter*="$attrValue"]';
            print('==Price==========${element.innerText.replaceAll(" ", "")}');
            setData(element.innerText.replaceAll(" ", ""));
          }
        }
      });
    });
  });
  print('=======price lenght===== ${titleSet.length}');
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
              print(
                  '------Title  data 2-------- ${element.attributes['content'].replaceAll(" ", "")}');
              setTitle(element.attributes['content'].replaceAll(" ", ""));
            }
          }
        } else if (element.innerText != null) {
          if (element.innerText.trim().isNotEmpty) {
            print(
                '------Title data 2-------- ${element.innerText.replaceAll(" ", "")}');
            setTitle(element.innerText.replaceAll(" ", ""));
          }
        }
      });
    });
  });
  print('=======Title lenght===== ${titleSet.length}');
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

                if (prop.contains('http')) {
                  print('------image up date-------- $prop');
                  setImage(prop);
                }
              }
            }
          } else if (element.innerText != null) {
            if (element.innerText.trim().isNotEmpty) {
              String data = element.innerText.replaceAll(" ", "");

              if (data.contains('http')) {
                print('=======imge data======== $data');
                setImage(data);
              }
            }
          }
        });
      }
    });
  });
  print('=======image lenght===== ${imageSet.length}');

  return imageSet.toSet().toList();
}
