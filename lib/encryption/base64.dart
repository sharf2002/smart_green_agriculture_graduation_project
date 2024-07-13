class Base64Codec {
  static const base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

  String encode(String data) {
    final bytes = data.codeUnits;
    final dataSize = bytes.length;
    final result = StringBuffer();

    int dataIndex = 0;

    while (dataIndex < dataSize) {
      int byte1 = bytes[dataIndex++];
      int byte2 = (dataIndex < dataSize) ? bytes[dataIndex++] : 0;
      int byte3 = (dataIndex < dataSize) ? bytes[dataIndex++] : 0;

      int enc1 = byte1 >> 2;
      int enc2 = ((byte1 & 0x03) << 4) | (byte2 >> 4);
      int enc3 = ((byte2 & 0x0F) << 2) | (byte3 >> 6);
      int enc4 = byte3 & 0x3F;

      if (dataIndex - 2 >= dataSize) {
        enc3 = enc4 = 64; // Pad with '='
      } else if (dataIndex - 1 >= dataSize) {
        enc4 = 64; // Pad with '='
      }

      result.write(base64Chars[enc1]);
      result.write(base64Chars[enc2]);
      result.write(enc3 == 64 ? '=' : base64Chars[enc3]);
      result.write(enc4 == 64 ? '=' : base64Chars[enc4]);
    }

    return result.toString();
  }

  String decode(String encodedData) {
    final result = <int>[];

    int dataIndex = 0;

    while (dataIndex < encodedData.length) {
      int enc1 = base64Chars.indexOf(encodedData[dataIndex++]);
      int enc2 = base64Chars.indexOf(encodedData[dataIndex++]);
      int enc3 = base64Chars.indexOf(encodedData[dataIndex++]);
      int enc4 = base64Chars.indexOf(encodedData[dataIndex++]);

      int byte1 = (enc1 << 2) | (enc2 >> 4);
      int byte2 = ((enc2 & 0x0F) << 4) | (enc3 >> 2);
      int byte3 = ((enc3 & 0x03) << 6) | enc4;

      result.add(byte1);
      if (enc3 != 64) result.add(byte2);
      if (enc4 != 64) result.add(byte3);
    }

    // Return string from result bytes excluding padding bytes
    return String.fromCharCodes(result.where((byte) => byte != 0));
  }
}