# 데이터베이스 옷 정보를 넣어 쉽게 옷을 매치하고 관리할 수 있는 온라인 옷장 홈페이지

- **Front-End**: HTML, CSS, JavaScript, jQuery
- **Back-End**: Spring, Flask

<br>

## 구현 목표
 - **오프라인에 있는 옷장을 온라인 웹 기반 데이터베이스에 저장하고 조회, 시각화하여 사용자가 쉽게 옷을 코디하고 확인할 수 있는 시스템을 구축하고 easyOCR을 통하여 사용자가 상표를 찍어 올리면 해당 제품 정보를 자동으로 찾아주고, 선택하면 쉽게 옷장에 저장할 수 있는 시스템을 구축하는 것을 목표로 합니다.**

<br>

## 구현 기능
### 상표 이미지 OCR 인식:
 - **OCR (Optical Character Recognition) 기술을 사용하여 사용자가 업로드한 상표의 주요 제품 정보를 추출.**
 ### 제품 정보 검색 기능:
 - **추출한 제품 정보를 바탕으로 Naver Search API를 이용하여 상세 정보를 사용자에게 제공.**
 - **Ajax와 같은 비동기 통신 방식을 사용하여 일정 데이터를 동적으로 처리**
### 옷 저장 기능:
 - **선택한 제품 정보의 상세 정보를 데이터베이스에 저장.**
### 옷 코디 기능 &캡쳐:
 - **나만의 옷장의 다양한 옷을 이미지 슬라이드(Image Slide) 기능을 통해 시각적으로 쉽게 찾고 드래그 앤 드롭(Drag and Drop) 기능을 적용하여 코디할 수 있는 기능.**
 - **HTML 캔버스(Canvas)의 이미지 캡처(Image Capture) 기능을 적용하여 코디한 옷을 이미지 파일로 저장할 수 있는 기능.**

### DB 구축 및 연동:
 - **Oracle 데이터베이스를 설계하고, JDBC를 통해 Spring 애플리케이션과 연동했습니다.**
 - **Oracle 18c를 사용하여 회원 정보 및 옷 데이터를 관리하기 위한 데이터베이스를 설계. 테이블 간 관계를 명확히 정의하고, 정규화를 통해 데이터의 무결성을 확보.**
- **aggle.com에서 제공하는 API를 활용하여 옷 데이터를 수집. 수집된 데이터를 전처리하여 Oracle 18c 데이터베이스에 저장.**

### 로그인 / 회원가입 시스템 구축:
 - **Spring Security를 사용하여 비밀번호의 보안을 강화.**
### 회원간의 커뮤니케이션을 위한 게시판:
 - **옷 정보 수집 및 공유를 위한 원활한 커뮤니케이션을 위해 게시판 기능을 추가**
 

<br>

## 느낀점 및 보완사항
### FullCalendar API 사용
- **API를 사용하면서 일정을 등록할때 일반적으로 ex)시작일자 : 2024.05.05 / 종료일자 : 2024.05.06 이라고 할 때, API에서는 종료일자가 2024.05.07 과 같이 사용.. endDate가 항상 독점적이고, 날짜 범위가 끝나는 시간이 다음 날 0시를 의미하기 때문이라고 함.. 어느 API이건 사용할 때는 Docs를 잘 참고하자..**

### 코드 리팩토링
- **코드를 짜면서 반복되는 기능들을 함수로 만들어서 하면 코드의 길이가 줄어들고 가독성이 개선될 부분이 많이 있었는데 해당 부분을 고려하지 않고 만들어서 가면 갈 수록 코드의 가독성이 떨어져 작업이 힘들었다.. 추후에 코드 리팩토링을 통해 가독성을 개선이 필요함..**

    

<br>
<hr>
<br>

## 메인화면
<p align="center">
  <img src="https://github.com/asder0705/SpringCloset/assets/150253403/3c6a4d56-5e12-4bd7-a7fa-706f529edc17" alt="main">
</p>
<br>
<hr>
<br>

## 옷 등록 화면
<p align="center">
  <img src="https://github.com/asder0705/SpringCloset/assets/150253403/5544b476-322f-4bec-b748-dfc4564c96e2" alt="closetupView">
</p>
<br>
- 대분류 중분류를 통하여 옷을 검색 할 수 있고 옷 등록 버튼을 통해 데이터베이스에 추가하 수 있고 아코디언 버튼을 클릭하여 상세정보 설명을 볼 수 있다.
<hr>
<br>

### 나의 옷장 화면
<p align="center">
  <img src="https://github.com/asder0705/SpringCloset/assets/150253403/d808ebdd-0c7e-4491-8030-9b59cd89e642" alt="create_plan1">
</p>
<br>
- 등록된 옷들을 볼 수 있고 삭제가 가능하다.
<hr>
<br>

### 옷장 코디 화면
<p align="center">
  <img src="https://github.com/asder0705/SpringCloset/assets/150253403/d95c6709-fd00-4acd-902c-d12baa70b0b5" alt="edit_plan1">
</p>
<br>
-- 선택된 옷들의 이미지를 slide로 한번에 볼 수 있고 drag and drop 을 통하여 옷을 선택하여 매치 한 후 파일 형태로 저장 할 수 있다.
<hr>
<br>

- **옷 텍 정보 easyOCR로 찾아오기** 
<p align="center">
  <img src="" alt="edit_plan2">
</p>
<br>
-- fileupload를 한 뒤 flack를 통하여 이미지 분류 후 네이버API키를 활용해 상품들을 나열한다.
<hr>
<p align="center">
  <img src="" alt="edit_plan2">
</p>
<br>



- **일정 추천**
<p align="center">
  <img src="" alt="recommendation plan with sections for morning, afternoon, and evening activities, and space for notes">
</p>

<p align="center">
  <img src="" alt="recommendation plan with time slots, activities, and goals for different parts of the day">
</p>
<br>
<hr>
<br>

- **세부 일정 추천**
<p align="center">
  <img src="" alt="detailed recommendation plan with categorized sections for tasks, goals, and priorities">
</p>

<p align="center">
  <img src="" alt="detailed recommendation plan with time slots, task categories, and spaces for notes and priorities">
</p>
<br>
<hr>
<br>


- **ChatGPT 채팅서비스**
<p align="center">
  <img src="" alt="chatGPT chat interface showing a conversation with a user, displaying text input and response sections">
</p>
