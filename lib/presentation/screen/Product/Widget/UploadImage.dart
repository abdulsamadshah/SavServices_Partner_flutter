import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/Utils/const_res.dart';

Widget buildUploadImageSection({
  required List<File> localImages,
  required List<dynamic> uploadedImageUrls,
  required VoidCallback onUploadPressed,
  required void Function(int index, bool isLocal) onRemove,
}) {
  final combinedImages = [
    ...uploadedImageUrls
        .map((url) => {'path': ConstRes.aImageBaseUrl + url, 'isLocal': false}),
    ...localImages.map((file) => {'path': file, 'isLocal': true}),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Product Images',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.h),

      /// Upload Area
      GestureDetector(
        onTap: onUploadPressed,
        child: DottedBorder(
          // color: Colors.grey,
          // radius: Radius.circular(12),
          // dashPattern: [6, 4],
          // strokeWidth: 1.2,
          child: Container(
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate,
                      size: 36.sp, color: Colors.grey),
                  SizedBox(height: 6.h),
                  Text(
                    'Tap to upload images',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 16.h),

      /// Preview Grid
      if (combinedImages.isNotEmpty)
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: combinedImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemBuilder: (context, index) {
            final item = combinedImages[index];
            final isLocal = item['isLocal'] as bool;

            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: isLocal
                      ? Image.file(
                          item['path'] as File,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          item['path'] as String,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Center(
                            child: Icon(Icons.broken_image, color: Colors.red),
                          ),
                        ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => onRemove(index, isLocal),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
    ],
  );
}
