import 'package:e_commerce_app/feature/chat/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubbleWidget extends StatelessWidget {
  final MessageModel message;

  const ChatBubbleWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = !message.isAdminSender;
    
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFBC954A) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isMe ? 16.r : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.attachedMetaData != null)
              _buildProductAttachment(),
            if (message.text.isNotEmpty)
              Text(
                message.text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductAttachment() {
    final metaData = message.attachedMetaData!;
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (metaData.productImageUrl != null && metaData.productImageUrl!.isNotEmpty)
            Image.network(
              metaData.productImageUrl!,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metaData.productTitle ?? 'Product',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              if (metaData.productPrice != null)
                Text(
                  '\$${metaData.productPrice}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.sp,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
