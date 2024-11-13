# FootballApp

### 프로젝트 개요

- 인원: 1명
- 기간: 2024.10.04 ~ 2024.11.06

### 한 줄 소개

- RapidAPI를 활용해 프리미어리그 팀순위, 경기결과, 선수 순위 및 경기 스쿼드 정보를 확인할 수 있는 앱

### 앱 미리보기

<table align="center" width="100%">
  <tr>
    <td align="center"><img src="https://imgur.com/XZFWXrl.gif" width="175"><br>팀 정보</td>
    <td align="center"><img src="https://imgur.com/Qd1J8bW.gif" width="175"><br>경기결과</td>
    <td align="center"><img src="https://imgur.com/9jz4dof.gif" width="175"><br>경기예정</td>
    <td align="center"><img src="https://imgur.com/RzZX0F2.gif" width="175"><br>득점 선수정보</td>
    <td align="center"><img src="https://imgur.com/asNY8QN.gif" width="175"><br>도움 선수정보</td>
  </tr>
</table>



### 개발 환경

- Deployment Target: 16.4
- Localizations: English
- App Appearances: Light

### 기술

- **Architecture** : `MVC`
- **UI** : `UIKit`
- **Network** : `URLSession`, `REST API` (via `RapidAPI`), `Result-based API 호출`
  - `NetworkProvider`를 통해 공통 네트워크 요청 관리
  - `FootballNetworkService`를 사용해 프리미어리그 경기 일정 및 결과 데이터 가져오기
- **Image Caching** : `NSCache`, `Disk Caching`
  - 메모리 및 디스크 캐시를 사용해 이미지를 효율적으로 관리하고, 불필요한 네트워크 요청을 최소화하여 앱 성능을 최적화
  - URL의 SHA-256 해시를 활용한 파일 이름으로 이미지의 중복 다운로드를 방지
- **Screen Navigation** : `Segmented Control`, `UIPageViewController`
  - `Segmented Control`을 사용하여 팀 순위, 경기 결과, 득점 순위 등 다양한 정보를 한 화면에서 손쉽게 전환할 수 있도록 구성
  - `UIPageViewController`와 결합하여 각 세그먼트를 선택할 때 애니메이션을 통한 부드러운 화면 전환을 제공하며, 사용자 경험을 향상
  - `UIPageViewControllerDelegate와` `UIPageViewControllerDataSource`를 활용해 현재 선택된 세그먼트와 화면을 동기화하여,    
     일관된 네비게이션 경험을 제공
- **StackView** 활용을 통한 통계 UI 구성
  - 프로젝트 내 다양한 화면 구성에서 `UIStackView`를 적극적으로 활용하여 통계를 간결하게 표현   
    스택뷰를 사용함으로써 코드 간소화와 함께 레이아웃의 일관성을 유지하고, 개별 구성 요소의 유연성을 높임
  
### 기능

- 팀 순위표
  - 스쿼드
  - 경기예정
  - 경기기록
- 라운드 별 지난 경기결과
  - 경기 정보
  - 경기 기록
  - 선수명단
  - 경기 통계  
- 라운드 별 경기예정
  - 경기 정보
  - 상대전적
- 득점 순위표
  - 선수 프로필
  - 지난 5개 시즌 통계
  - 이력 (이적정보)
- 도움 순위표
  - 선수 프로필
  - 지난 5개 시즌 통계
  - 이력 (이적정보)



---

### 주요 성과

- **ㅇㅇ**:  
  
  ㅇㅇㅇㅇ


---

## 트러블 슈팅

### 1️⃣ ㅇㅇ
#### 🤔 **상황**  


#### 🚨 **문제**

- ㅇㅇ

#### 🛠️ **해결 과정**

ㅇㅇ


#### 📝 **결과**

ㅇㅇ

<br>

### 2️⃣ ㅇㅇ







