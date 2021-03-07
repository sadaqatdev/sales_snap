// "product-info",
// "product-detail",
// "item-name",
// "product-name",
// "productName",
// "lblProductName",
// "lblProduct",

const productAttributeMap = {
  "titles": [
    "title",
    "[property*='og:title']",
    "[itemprop*='name']",
    "[id*='product-title']",
    "[class*='product-title']",
    "[id*='product-name']",
    "[class*='product-name']",
    "[id*='title']",
    "[class*='title']",
    "[id*='-title']",
    "[class*='-title']",
    "[id*='Title']",
    "[class*='Title']",
    "[id*='-Title']",
    "[class*='-Title']",
    "[id*='_Title']",
    "[class*='_Title']",
    "[id*='pdp-title']",
    "[class*='pdp-title']",
    "[id*='itemTitle']",
    "[class*='itemTitle']",
    "[id*='item-name']",
    "[class*='itemTitle']",
    "[id*='productName']",
    "[class*='productName']",
    "[id*='lblProduct']",
    "[class*='lblProduct']",
  ],
  "images": [
    "[property*='og:image']",
    "[id*='product-image']",
    "[class*='product-image']",
    "[id*='MainImage']",
    "[class*='MainImage']",
    "[id*='mainImage']",
    "[class*='mainImage']",
    "[id*='-image']",
    "[class*='-image']",
    "[id*='_Image']",
    "[class*='_Image']",
    "[class*='pdp-image']",
    "[id*='mainImage'] img",
    "[class*='mainImage'] img",
    "[id*='Imagery'] img",
    "[class*='Imagery'] img",
    "[id*='pdp-image'] img",
    "[class*='pdp-image'] img",
    "[id*='itemImage']",
    "[class*='itemImage']",
    "[id*='item-name']",
    "[class*='itemImage']",
    "[id*='productImage']",
    "[class*='productImage']",
  ],
  "prices": [
    "nowPrice",
    ":price:amount",
    ":price:currency",
    "priceCurrency",
    "price",
    ":price:amount",
    "price",
    "-Price-amount",
    "-Price",
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
    "-price",
    "Price",
    "price--large",
    "price",
  ],
};
const filters = [
  "property",
  "name",
  "itemprop",
  "item-prop",
  "id",
  "class",
  "data-test-element",
  "data-test-id",
  "data-test",
];

bool  isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}