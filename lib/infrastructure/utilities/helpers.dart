import 'dart:math' show Random;

abstract class Helpers {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static DateTime randomDateTime() {
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }

  static String randomCode() {
    var rng = Random();
    int codigo = rng.nextInt(100000);
    return codigo.toString().padLeft(5, '0');
  }

  // static String getChannelName(Channel channel, User currentUser) {
  //   if (channel.name != null) {
  //     return channel.name!;
  //   } else if (channel.state?.members.isNotEmpty ?? false) {
  //     final otherMembers = channel.state?.members
  //         .where(
  //           (element) => element.userId != currentUser.id,
  //         )
  //         .toList();

  //     if (otherMembers?.length == 1) {
  //       return otherMembers!.first.user?.name ?? 'No name';
  //     } else {
  //       return 'Multiple users';
  //     }
  //   } else {
  //     return 'No Channel Name';
  //   }
  // }

  // static String? getChannelImage(Channel channel, User currentUser) {
  //   if (channel.image != null) {
  //     return channel.image!;
  //   } else if (channel.state?.members.isNotEmpty ?? false) {
  //     final otherMembers = channel.state?.members
  //         .where(
  //           (element) => element.userId != currentUser.id,
  //         )
  //         .toList();

  //     if (otherMembers?.length == 1) {
  //       return otherMembers!.first.user?.image;
  //     }
  //   } else {
  //     return null;
  //   }
  //   return null;
  // }
}
