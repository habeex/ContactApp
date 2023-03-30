import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reqresapp/model/user_model.dart';

class UserTile extends StatelessWidget {
  UserTile({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: user.avatar ?? '',
                fadeInDuration: const Duration(seconds: 1),
                placeholderFadeInDuration: const Duration(seconds: 1),
                imageBuilder: (context, imageProvider) => Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.blue.withOpacity(.6), BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.7),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: Center(
                      child: Text(user.firstName![0].toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    )),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('${user.email}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          const Divider(thickness: 1),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
