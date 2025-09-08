<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry_edit.css" />
	</head>
		
	<body>
		<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
		<div class="container">
		
			<!-- 사이드 메뉴 -->
			<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>
		
			<div class="inquiry_edit_main">
				<div class="inquiry_edit">
					<h3 class="inquiry_text">&nbsp;Question</h3>
					<table class="customer_question">
						<tr>
							<td class="table_title">결제가 잘 안돼요<span>07.02 10:31</span></td>							
						</tr>
						<tr>
							<td><img src="image/inquiry_file.png" class="inquiry_img" alt="파일 이미지">첨부파일.jpg</td>
						</tr>
						<tr>
							<td>(서울=연합뉴스) 김은경 기자 = 푹푹 찌는 무더위가 전국을 강타하면서 전국 각지에서 6월 일평균 기온 최고 기록이 줄줄이 경신됐다.
								1일 기상청에 따르면 부산에서는 6월의 마지막 날인 전날 일평균 기온이 26.2도를 기록하며 1904년 4월 관측 이래 역대 6월 중 가장 더운 날로 기록됐다.									
								부산에서는 그보다 하루 전인 지난달 29일 25.9도의 일평균 기온을 기록하며 이미 6월 기록이 한차례 바뀐 바 있다.								
								이전 기록은 2024년 6월 15일 25.8도다.								
								같은 시기 관측을 시작한 목포에서도 28.1도로 새 기록이 나왔다.									
								목포 역시 지난달 29일 27.3도로 새 기록을 쓴 바 있다.
							</td>
						</tr>
			        </table>
				</div>
				
				<div class="inquiry_edit">
					<h3 class="inquiry_text">&nbsp;Answer</h3>
					<table class="customer_answer">
						<tr>
							<td class="table_title">
								<input type="text" name="answerHeader" class="answerHeader" value="안녕하세요. Good Luck 입니다.">
							</td>			
						</tr>
						<tr>
							<td><textarea name="answerBody" class="answerBody">7월은 여름이다. 여름은 덥다. 7월은 덥다.</textarea></td>
						</tr>
			        </table>
				</div>
				<div class="search-buttons">
		        	<button class="btn-submit">수정</button>
		        	<button class="btn-reset">취소</button>
				</div>
			</div>
		</div>
	</body>
</html>