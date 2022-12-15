# RxTimer
Rxswift 를 이용한 Timer와 이미지 생성기
이미지를 불러오면 타이머가 기록됩니다.

<img width="258" alt="스크린샷 2022-12-16 오전 2 03 26" src="https://user-images.githubusercontent.com/57595198/207922716-8cbc563e-bbf6-42ca-bfd7-1ba2ef851182.png"><img width="258" alt="스크린샷 2022-12-16 오전 2 03 49" src="https://user-images.githubusercontent.com/57595198/207922776-0d95f154-3fde-4ebf-aefb-f164e1c3cb77.png">



# 구현
- RxSwift와 MVVM 구조로 구현했습니다.
- RxSwift의 Observable을 사용해 비동기적으로 URL로 부터 사진을 들고왔습니다.
- RxSwift의 Subject를 사용해 Observable간의 데이터를 전달했습니다.
- RxCocoa를 사용해 TableView를 구현했습니다.

# 느낀 점
- Data를 받아오는 APIService 구현 부분에서 onComplete를 잘못 사용해 스트림이 끊기는 문제가 발생했었습니다. 
  - Observable의 흐름과 onComplete를 사용해야하는 상황을 알게 되었습니다.
- Observable과 Observer, Subscribe을 직접 사용해보며 흐름과 역할을 이해했습니다.
