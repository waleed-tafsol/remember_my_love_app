String storageSizeUnit(num sizeInMB, {int decimals = 2}) {
  if (sizeInMB <= 0) return "0 MB";
  if (sizeInMB >= 1024) {
    double sizeInGB = sizeInMB / 1024;
    return '${sizeInGB.toStringAsFixed(decimals)} GB';
  } else {
    return '${sizeInMB.toStringAsFixed(decimals)} MB';
  }
}
