import 'item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Brain {
  int _itemNumber = 0;

  String getItemName() {
    return _itemBank[_itemNumber].name;
  }

  String getNextItemName() {
    return _itemBank[_itemNumber + 1].name;
  }

  double getItemPrice() {
    return _itemBank[_itemNumber].price;
  }

  double getNextItemPrice() {
    return _itemBank[_itemNumber + 1].price;
  }

  String getItemPicture() {
    return _itemBank[_itemNumber].picture;
  }

  String getNextItemPicture() {
    return _itemBank[_itemNumber + 1].picture;
  }

  void nextItem() {
    if (_itemNumber < _itemBank.length - 1) {
      _itemNumber++;
    }
  }

  int getTotal() {
    return _itemBank.length;
  }

  bool isFinished() {
    if (_itemNumber >= _itemBank.length - 2) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _itemNumber = 0;
  }

  List<Item> get itemBank => _itemBank;

  int getItemBankTotal() {
    return _itemBank.length;
  }

  void shuffleList() {
    _itemBank.shuffle();
  }

  final List<Item> _itemBank = [
    Item(r'this costs 3000', 3000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 4000', 4000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 5000', 5000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 6000', 6000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 7000', 7000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 8000', 8000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 9000', 9000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 10000', 10000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 11000', 11000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item(r'this costs 12000', 12000.94,
        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
    Item('Tesla Model S', 64000.94,
        "https://tesla-cdn.thron.com/delivery/public/image/tesla/56cb8c41-e898-44ce-b6b7-fe9b9a05f529/bvlatuR/std/1200x628/MS-Social"),
  ];
}
