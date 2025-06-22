String formatDate(dynamic date) {
  if (date == null) return 'N/A';
  try {
    DateTime parsedDate = DateTime.parse(date.toString());
    DateTime now = DateTime.now(); // Current date: 2025-06-17 01:17 AM EEST

    Duration difference = now.difference(parsedDate);

    if (difference.inMinutes < 60) {
      // Less than 1 hour
      int minutes = difference.inMinutes;
      return minutes == 0 ? 'Just now' : '$minutes minute${minutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      // Less than 24 hours
      int hours = difference.inHours;
      return '$hours hour${hours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      // Less than 7 days
      int days = difference.inDays;
      return '$days day${days == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 30) {
      // Less than 30 days
      int weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      // Less than a year
      int months = (difference.inDays / 30).floor();
      int remainingDays = difference.inDays % 30;
      if (remainingDays == 0) {
        return '$months month${months == 1 ? '' : 's'} ago';
      } else {
        return '$months month${months == 1 ? '' : 's'}, $remainingDays day${remainingDays == 1 ? '' : 's'} ago';
      }
    } else {
      // Older than a year
      return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
    }
  } catch (e) {
    return date.toString();
  }
}