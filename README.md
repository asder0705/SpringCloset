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
  <img src=https://github.com/asder0705/SpringCloset/assets/150253403/89bf39b1-7ae9-4994-ac40-2d1468bf8121"" alt="edit_plan2">
</p>
<p align="center">
  <img src="https://github.com/asder0705/SpringCloset/assets/150253403/1d4e3126-c8fe-4f5e-81ee-7341a33f5af5" alt="edit_plan2">
</p>
<br>
-- fileupload를 한 뒤 flack를 통하여 이미지 분류 후 네이버API키를 활용해 상품들을 나열한다.
<hr>


## 느낀점 및 보완사항
### css
- **기능에 신경 쓰다 보니 화면이 매끄럽지 못했고 화면 간격이나 margin에 대한 이해가 부족하여 비율이 잘 맞지 못했다. 이런 부분에 있어서 고객이 원하는 바가 있을 수 있으므로 더 공부해야겠다.**

### 디버깅
- **오류를 해결하는 과정에서 디버깅을 통해 코드를 다시 짜보고 실행해보는 과정에서 성장을 많이 한 것 같다.반복해서 같은 부분이라도 뭐가 들어왔는지 보고 오류를 찾아내서 해결하는 부분에서 문제 해결 능력이 상승하는 것을 느낄 수 있었다.**




