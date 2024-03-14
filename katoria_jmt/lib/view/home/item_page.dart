// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:katoria_jmt/common/color_extension.dart';
import 'package:katoria_jmt/view/home/addnewpage_view.dart';
import 'package:katoria_jmt/view/model/page.dart';

class ItemPage extends StatelessWidget {
  final MyPage page;
  const ItemPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // we need to pass the current page inside the build context of this screen
        Navigator.push(
            context,
            MaterialPageRoute(
                // TODO item page navigation

                builder: (context) => AddPage(
                      page: page, onDeleted: () {  },
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: TColor.primaryAlpha),
              //dumby practice notes in jounral
// date area
              child: Column(
                children: [
                  Text(
                    // 'Mar',
                    DateFormat(DateFormat.ABBR_MONTH).format(page.createdAt),
                    style: TextStyle(color: TColor.tertiaryText),
                  ),
                  SizedBox(height: 3),
                  Text(
                      // '12',
                      DateFormat(DateFormat.DAY).format(page.createdAt),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: TColor.tertiaryText,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text(
                    // '2024',
                    page.createdAt.year.toString(),
                    style: TextStyle(color: TColor.tertiaryText),
                  )
                ],
              ),
            ),
// date area end

            SizedBox(width: 15),
// title/ description area

            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // 'Title',
                        page.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      // "12:30pm",
                      DateFormat(DateFormat.HOUR_MINUTE_SECOND)
                          .format(page.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Text(
                  // 'body description',
                  page.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )),
            SizedBox(width: 10),
// area for user added image
            if (page.image.isNotEmpty)
              Image.memory(Uint8List.fromList(base64Decode(page.image)),
                  width: 50, height: 50),
          ],
        ),
      ),
    );
  }
}
