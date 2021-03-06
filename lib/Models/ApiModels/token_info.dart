///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class TokenInfo {
  String? accessToken;
  int? expiresIn;
  int? lastUpdateTimestamp;
  String? tokenType;

  TokenInfo({
    this.accessToken,
    this.expiresIn,
    this.lastUpdateTimestamp,
    this.tokenType,
  });
  TokenInfo.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token']?.toString();
    expiresIn = json['expires_in']?.toInt();
    lastUpdateTimestamp = json['last_update_timestamp']?.toInt();
    tokenType = json['token_type']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['last_update_timestamp'] = lastUpdateTimestamp;
    data['token_type'] = tokenType;
    return data;
  }
}
