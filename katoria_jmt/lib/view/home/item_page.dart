// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:katoria_jmt/common/color_extension.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: TColor.primaryAlpha),
            //dumby practice notes in jounral
            child: Column(
              children: [
                Text(
                  'Mar',
                  style: TextStyle(color: TColor.tertiaryText),
                ),
                SizedBox(height: 3),
                Text('12',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: TColor.tertiaryText,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 3),
                Text(
                  '2024',
                  style: TextStyle(color: TColor.tertiaryText),
                )
              ],
            ),
          ),
          SizedBox(width: 15),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "12:30",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Text(
                'body description',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ))
        ],
      ),
    );
  }
}
