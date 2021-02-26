const productAttributeMap = {
    price: [
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
let dataSet = [];
const setData = (_data) => {
    dataSet.push(_data);
    console.log("dataSet", dataSet);
};

function getData() {
    productAttributeMap.price.map((attr_value) => {
        filters.map((filter) => {
            const _data = document.querySelectorAll(`[${filter}*="${attr_value}"]`);
            if (_data.length > 0 && dataSet.length < 3) {
                if (
                    filter === "property" ||
                    filter === "itemprop" ||
                    filter === "item-prop"
                ) {
                    setData(_data[0].getAttribute("content"));
                    if (_data[1] !== undefined) setData(_data[1].getAttribute("content"));
                } else {
                    setData(_data[0].innerText.split("\n")[0].trim());
                }
            } else {}
        });
    });
}

getData();
console.log(dataSet);

{
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
}