class AppwriteConstants {
  static const String databaseId = '65732f16d6dd367dff70';
  static const String projectId = '65732c82ecd547f20c85';
  static const String endPoint = 'http://192.168.1.11:98/v1';

  static const String usersCollection = '65745595c857c70844db';
  static const String tweetsCollection = '6576cd8e0d9463f29a8e';
  static const String notificationsCollection = '65794f0310474a5c3050';


  static const String imagesBucket = '6575a2a013eb66ca8571';

  static String imageUrl(String imageId) => 
          '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}  