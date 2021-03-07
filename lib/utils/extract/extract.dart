import 'package:sales_snap/utils/extract/extract-consts.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';
 
 
var dataSet = [];
setData(_data) {
  dataSet.add(_data);  
}

getData(String domData) {
  final htmlDocument = parseHtmlDocument(domData);

  productAttributeMap['prices'].forEach((attrValue) {
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

 
