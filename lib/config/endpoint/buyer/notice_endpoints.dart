abstract class NoticeEndpoints {
  // 공지사항 목록 조회
  static String getNotice = '/api/notice';

  // 공지사항 상세 조회
  static String getNoticeDetail({required int noticeId}) {
    return '/api/notice/$noticeId';
  }
}
