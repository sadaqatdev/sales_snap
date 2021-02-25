const CssTokens = [];
const ar = {
  "price": [
    '[class*="Price"]',
    'product-price',
    '[class*="current-price"]',
    '[class*="current-price]',
    '[class*="price]',
    '[class*="price--"]',
    '[data-test="product-price"]',
    '//*[starts-with(@*, "price__")]',
    '[itemprop="price"]',
    '[id*=product-main] [class*="ProductPriceBlock__Price-eXasuq IsQih"]',
    '[class*="xs-block] [class*="itemprop="price"]',
    '[class*="CenterPanelInternal] [class*="itemprop="price"]',
    '[id*=priceblock_dealprice]',
    '[class*="price__container] [class*="price__element price__element--formatted"]',
    '[data-test-element="product-price"]',
    '[class*=""special-price""]',
    '[class*="price"]',
    '[class*="current-price"]',
    '[class*="current-price"]',
    '[class*="ty-price"]',
    '[class*="markdown-prices"]',
    '[class*=price-box price-final_price]',
    '//*[starts-with(@*, "product-info-price")]',
    '//*[starts-with(@*, "product-page-price" )]',
    '//*[starts-with(@*, "BasePriceBlock")]',
    '//*[starts-with(@*, "product-price")]'
  ],
  "image": [
    '[class*="pdp-image"]',
    '[class*=""product media"]',
    '[property="og:image"]',
    '[class*="product-gallery"]',
    '[class*="productView-images"]',
    '[class*="product-main-images img"]',
    '[property="og:url"]',
    '[itemprop="image"]',
    '[id*=core-product] [class*="gallery-image"]',
    '[id*=og:image]',
    '//*[starts-with(@*, "ty-product-img cm-preview-wrapper")]',
    '//*[starts-with(@*, "pl-FluidImage-image")]',
    '[class*="image-grid__]',
    '[class*=fashion-app-root] [class*=selected-image--1aDYM]',
    '[class*=product-gallery__]',
    '[id*=product-main] [class*="sticker"]',
    '[class*=xs-block .Sliderstyles__Slide-sc-1w0ebdo-1 jjEbBd]',
    '[class*=CenterPanelInternal id="viEnlargeImgLayer_img_ctr"]',
    '[id*=imgTagWrapperId] .imgTagWrapper]',
    '[class*=ng-star-inserted ls-is-cached lazyloaded]',
    '[data-test-element="product-gallery"]',
    '[class*="image-media"]',
    '//*[starts-with(@*, "loaded--img")]',
    '//*[starts-with(@*, "--img")]',
    '[data-test="component-media-gallery_activeSlide-0"]',
    '[property="og:image"]',
  ],
  "title": [
    '[property="og:title"]',
    '[class*="ProductD"]',
    '[class*="product-details-tile"]',
    '[id*=core-product] [class*=product-hero]',
    '[class*=product-hero]',
    '[class*=product-info] [class*=product-info__title]',
    '//*[starts-with(@*, "__title")]',
    '//*[starts-with(@*, "title--")]',
    '[class*=pdp__name]',
    '[itemprop="name"]',
    '[id*=product-main]',
    '[itemprop="name"]',
    '[data-test="product-title"]',
    '[class*=CenterPanelInternal .it-ttl]',
    '//*[starts-with(@*, productTitle)]',
    '[class*=product-intro__name]',
    '//*[starts-with(@*, __name)]',
    '[data-test-element="product-name"]',
    '[class*="product-name"]',
    '[class*=product-name]',
    '[id*=product-name]',
    '[class*=mobile-title]',
    '[data-test="product-title"]',
    '[class*=name]',
    '[class*=page-title]',
    '[class*=pl-Heading]',
    '[class*=productView-title]',
    '[class*=product-block-title]',
    '[class*=product-title]',
    '[class*=product-name]',
  ],
};

//
// [property="og:image"]
// [property="og:url"]
// [property="og:type"]
// #product-price
// .product-item-headline
// .pdp-image
// .class="price"
// class="page-title"
// class="product media"
// class="pl-Heading"
// class="BasePriceBlock"
// class="pl-FluidImage-image"
// class="price product-page-price "
// class="product-gallery"
// class="productView-title"
// class="product-info-price  price-section--minor"
// class="price-box price-final_price"
// class="productView-images"
// class="product_title"
// class="price"
// class="ty-product-block-title"
// class="ty-price"
// class="ty-product-img cm-preview-wrapper" < img
// data-id="current-price",
// class="current-price"

// <meta property="og:type" content="product">
// <meta property="og:title" content="Acacia Gum Powder (Acacia senegal)">
// <meta property="og:url" content="https://www.woodlandherbs.co.uk/acatalog/acacia_gum_powder_arabic_gum.html">
// <meta itemprop="image" content="https://www.woodlandherbs.co.uk/acatalog/Acacia-gum-400.jpg">
// <meta itemprop="identifier" content="mpn:1951">
// <meta itemprop="brand" content="">
// <meta itemprop="name" content="Acacia Gum Powder (Acacia senegal)">
// <meta itemprop="description" content="Acacia Gum Powder Size: 50g     ">
