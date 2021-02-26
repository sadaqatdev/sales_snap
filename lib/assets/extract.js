const attrObj = {
    price: [
        ":price:amount",
        ":price:currency",
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
    "class",
    "id",
    "item-prop",
    "itemprop",
    "data-test-element",
];
let dataSet = [];
const setData = (_data) => {
    dataSet.push(_data);
    console.log("dataSet", dataSet);
};

function getData() {
    attrObj.price.map((attr_value) => {
        filters.map((filter) => {
            const _data = document.querySelectorAll(`[${filter}*="${attr_value}"]`);
            if (_data.length > 0 && dataSet.length < 3) {
                if (filter === "property") {
                    setData(_data[0].getAttribute("content"));
                } else {
                    setData(_data[0].innerText.split("\n")[0].trim());
                }
            } else {}
        });
    });
}

getData();
console.log(dataSet);