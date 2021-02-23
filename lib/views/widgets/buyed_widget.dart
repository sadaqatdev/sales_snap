import 'package:flutter/material.dart';

class BuyedTab extends StatelessWidget {
  const BuyedTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return BuyedTileWidget();
      },
    ));
  }
}

class BuyedTileWidget extends StatelessWidget {
  const BuyedTileWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
          elevation: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                'https://cdn.shopify.com/s/files/1/1083/6796/products/product-image-187878776_400x.jpg?v=1569388351',
                width: 100,
                height: 100,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AvaCado',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'This is a freebie for everyone, \nbut if u wanna invite me a beer',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    '16\$',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          )),
    );
  }
}
