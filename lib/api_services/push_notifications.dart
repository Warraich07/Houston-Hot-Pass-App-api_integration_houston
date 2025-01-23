import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
class PushNotifications {
  static Future<String> getAccessTokens() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "houston-hotpass-70db2",
      "private_key_id": "782114774b13c718e54e2acf02d3a4e284fa782f",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCxhZAqSEiDEnmT\n1n+OJvkj1ZD9EpgYwSz+8o7MkKPSr0mpHE29Jmu4eaZZtJvnltWggAosTJ+rdfAv\nDGkFeuFAOzHL1GZOtNTFO3YBKUw+kOYh1+GhX8tKIuQBU575v80GGknaNXirmymC\neiLNzxZ9chByz0rvnYcTUvnG9lc55EFyBpcRC+oR59C8HdRKDwRtO9esBgaI1vBP\nyYVcLuDvsygXOHynXY88O/x4M3LtnoD7zmq0JYgeQSR6LK/V560rbPyC+NLIptOv\nRaYtdg1J1dEJiyOq/51ZCR4qgopFpY3qtMBAkZxObX5ZtVi2d1ToiQBmdhfELRFe\nhTkxXcLBAgMBAAECggEADYVGMyo5N55vGxbxtSJ7xEJuXhAN/IiuBCb2QFdd2tyV\n6CbrNtZXyv+c72UloLBoyeYmoDQfzx/W8MZps0ymHk3D36noNuNn9zOtq635DCTe\nGkLGgRN6OMXKht1XFN+KXoYfDNsYuz1Anprtzq4QoPJQlWX7Z5+gW5TsyD4X66U5\nskV4QvEROsLJ5X2VB+kPvOoBwBOWSgaqUSB3sBg1RPR78ea3dTf9Fo0bTILkLSxL\nAg6EG/B8t7gRoe6Jz2pOgXsPgJ+qI6xp8UwZJt4WuOev2VIIsAxMsg9moRvEYl4L\nSHxoWULgsemqAwq27nQAvhBr4Drd1arEZfJmqVM8HwKBgQDvvkDlTeHdPr3vOKwl\nwAdLbxBdSTRh38gBeel2u/aEIABTJAY7PDtMWa6JKyriQghrTEl95S/OG1PS03Qm\n4+7l9IqWDUgkKtHClEJ6Nzqb+S37/ra3ksxVFKp8TG0KMfx0sluW+BHcWTDQ9/Zf\n4Wjs+Tf+QRXDbPZMuG1Ued8fJwKBgQC9jzIqRCJ5+QnK7soMa7b2nZvxQ/POrzcS\nv0TE3yemX9qVpE7uq4CC6jxSXlVH96WQbG8yR3rVnndkRLpX3aFjjHQiNnHKXwdF\nYclfqTzfwyitoLJrHam+QqwXhRST11Mou6I6dKvb65Oc6Hc/jHZumUYWWGuVbCJG\njFuCkTA/1wKBgQDLp9qI7/gGcd328TWLe+y2b8p+9EjDO84zMtTYQCPRaT3dYqTI\nfQoCecyCSWFMgruUKmHjyGUruJskZOwufUHbpjhz7yRxVM6LdFZka7Yl+S7O+jlN\nCC77t2p73JBkMMI8f6a+QE0r2bhWS83G9Tyk0bB3E+Lg+BbiZWi6cizP0QKBgFGU\niCVyj1fpGxLQM/qmfOakLBHoicwg0lXqJUGJPLo4tI0EWsgS3Ur6Xh2g5ZkEdqey\nUyTTaIT5Hy7y+TOJecSrFOwIfG54+Vsd25mk70Lp7d7TsxWwfXYZoZC5wIJkADEe\nl5IK1k/ekffMgE3EONAefPBu+1YiZJnyHAwUSiyfAoGBAJ+ppL7+A+V1q7Dj2G3Q\nLPT2sM+JC6RnyNi/hq7sW6mFRSzIR6VOddlgT3QKwuozkFi69qQd7lZg2RC3P2BM\ngEkodsUvf9RQtIlpLddZM/c+fchlNJMeVwKEbpu1ZXW6gD866Bz3xyK2zU4U9PYK\nowjyZP9Rur7MQQpbPBOoxImc\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-nlveg@houston-hotpass-70db2.iam.gserviceaccount.com",
      "client_id": "115801374092113372646",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-nlveg%40houston-hotpass-70db2.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
      // "type": "service_account",
      // "project_id": "houston-hotpass-user",
      // "private_key_id": "01d7787cf03acd5fc02a890bd29c739f18c89c7b",
      // "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDAWmC1r8lwHHeD\nCjGRSzY53fZeE3yBrAX4YysvMFj/zzE99ZeLWP7NXHRg5M0O1fz7mBsqclG/ZDms\nL898yTUo78ZY+REmJxeS27cUyVuMhXH43E0XxUnlSU+n3W775l8YdNUyc1YDHacM\n2MWuqUGyGCw4GLrF5eecPB47JMOIFeoavGC1e11ZnPHJDXBuH0Hx+T16K8FyCOD1\nSs8IOTR/bl6rRAAPTyUUO3xpXwig/mO/5LLbIIyihk7764GQH6RA5d36AngT/sy9\n+kvmxmPOd5Xnk7AO5PfKGrZeUoZ2k/BpjOYooRSSw3gdvkFKKAcrRIvtQszov8QW\nSZHlFkEXAgMBAAECggEAAz1CZazj1+HS2BUYMpnb/EDTAPs+XIdYw7m/z21MAmWA\nhHTvVrxqm2tpgPw5a9I0uXPyo9YFrxMcBDH7QjRikyGT6zRT5/A+mGLfhBfD/+t7\nY4p/jd1CWlHQEplLC4OcqbJwqLHX3/jkMvYvlg+++Hspu3lxznAJuiV/s3/x/weq\no6eYKM1HbSq0v4qcccaXQQbGWaMC1W8twg/A0QmAXf1dD5zHQYhODK11oKlIxzvB\nfKcMRTJEolf4Y2uWafNGpohlx/o0aaGQhxc9wTMRVeuB2KZMHrexWjpmrX4OvQ/l\nvo7RVnjimQb2Yw2TBQiX1WrRgYillkD9rXiILR8MaQKBgQDhipn+o9dgqMqdhNSj\nyeQpLMzO/h9pY+2AmJTwMy8p+l8sijf0KbM8QmiY7KX6PmmAUJPglG6Ego6cZXyv\nvwEkKDpDI09O8kdB46cQRmlNCMdbjFZGB0g9ZoikUmAaqRRNrcnBFFnk0/pfFfzR\ncFoh3hq6XJtH5tsljjH6FFjmtQKBgQDaVGP97W5uFxUm0spQsDT7UtBCKcZ+dMhK\nz99+7dyjkqcJY1iLZkpvlsoUtfVqvMPipO18UbRQMrFmflC0O+PUzdC41BMFmn42\ngGFq/1nzDdzRPq0dZ3PjTvvdB/zh/oZ8C8+KOKSl1IledVMCiWfxq36nf+sRSQvV\n3I1aWcW8GwKBgBENZKU/B/qz6FXOhDE6A3klfPqtdfyG5J8Tajda91bqKiX48VAR\nkw6cSsI9KjNoYpuj+/o/3rdAE745Yhr7iv+L1xPaaJWkdcTCjJALcsyzPDdsvd0f\nkdOqm+womkGJxRI2cImbm0xUxppH1EyVfQsQet7aP5dJGgqV3Kt2vF39AoGABQl9\nZRZdPdz6d/LVCBeIoWO/ukcMdU5scI1rMpp6RKvVfrn0CQNLJFfuQZwRFW1Vd50m\nfX/FETSaMysm4YGgOACnmBwMdEykLM25caaChMEFHy66/7qrSctAtFDC3NPqdmIv\nX5j+83R71toOGDjjVQgH3AVvfu6Yf06fVD5N+ZECgYALAuQQEYIFHDYre4jBBKkx\n3/CFfFEKkgkiM7j76kJ3C8gw1RWup6h1Ohjb7po45ucCuUqAjS1F9opxQGpwGeSJ\n+c2l8ixzbLl9AQyQwNXeIGU0KepN40fgpPTBEMLTkwfM/RNz0znZdGefzlMXhjQv\nJpRyqA6NdaWrEg4Mr8uoWQ==\n-----END PRIVATE KEY-----\n",
      // "client_email": "firebase-adminsdk-hqpfk@houston-hotpass-user.iam.gserviceaccount.com",
      // "client_id": "112207360591338652951",
      // "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      // "token_uri": "https://oauth2.googleapis.com/token",
      // "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      // "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-hqpfk%40houston-hotpass-user.iam.gserviceaccount.com",
      // "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email',
    ];
    http.Client client = http.Client();
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );
    client.close();
    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(String deviceToken) async {
    final String serverKeyAccessToken = await getAccessTokens();
    log(serverKeyAccessToken);

  }
}


// String endPointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/beauty-connect-9d187/messages:send';
// final Map<String, dynamic> message = {
//   'message': {
//     'token': deviceToken,
//     'notification': {
//       'title': 'title is',
//       'body': 'body is'
//     },
//     // 'data':
//     // {
//     //   'tripID': tripId
//     // }
//   }
// };
//
// final http.Response response = await http.post(
//   Uri.parse(endPointFirebaseCloudMessaging),
//   headers: <String, String>{
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $serverKeyAccessToken'
//   },
//   body: jsonEncode(message),
// );
//
// if (response.statusCode == 200) {
//   print("notification sent");
// } else {
//   print("notification not sent ${response.statusCode}");
// }