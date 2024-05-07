import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:warmindo_admin_ui/utils/themes/icon_themes.dart';

class DetailOrderBnb extends StatelessWidget {
  const DetailOrderBnb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hubungi'),
                    SizedBox(height: 5),
                    Container(
                      width: 30,
                      height: 40,
                      child: SvgPicture.asset(IconThemes.iconWhatsapp),  
                    ),
                  ],
                ),
                Container(
                  width: 70,
                  height: 65,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              ],
        ),
      ),
    );
  }
}