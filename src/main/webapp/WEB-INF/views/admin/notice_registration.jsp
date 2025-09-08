<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice_registration.css" />
		<script src="${pageContext.request.contextPath}/js/notice_registration.js" defer></script>
	</head>
		
	<body>
		<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
		<div class="container">
		
			<!-- 사이드 메뉴 -->
			<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>
		
			<div class="notice_registration_main">
				<div class="notice_registration">
					<h3 class="notice_text">공지사항 등록</h3>
					<div class="table_wrapper">
						<table class="displaySettings">
							<tr>
								<th colspan="2" class="table_title">표시 설정</th>
							</tr>
							<tr>
				                <th>표시 상태</th>
				                <td>
					                <div class="radio-group">
					                    <label><input type="radio" name="displayType" checked>표시함</label>
					                    <label><input type="radio" name="displayType">표시안함</label>
						            </div>
					            </td>
					        </tr>
					        <tr>
					        	<th>유형 선택</th>
					        	<td>
					        		<div class="radio-group">
					        			<label><input type="radio" name="noticeType" checked>기본</label>
					        			<label><input type="radio" name="noticeType">긴급</label>
					        		</div>
					        	</td>
					        </tr>    
				            <tr>
				            	<th>분류 선택</th>
				            	<td class="category_filter">
				            		<select>
			            				<option>선택</option>
			            				<option>디지털</option>
			            				<option>음향기기</option>
			            				<option>주방가전</option>
			            				<option>계절가전</option>
			            				<option>생활가전</option>
		            				</select>
		            			</td>
				            </tr>
				            <tr>
				            	<th>권한(읽기)</th>
				            	<td class="category_filter">
				            		<select>
			            				<option>선택</option>
			            				<option>비회원</option>
			            				<option>회원</option>
			            				<option>관리자</option>
		            				</select>
		            			</td>
				            </tr>
				        </table>
				            
				        <table class="basicInformation">
				        	<tr>
								<th colspan="2" class="table_title">기본 정보</th>
							</tr>    
							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="noticeName" class="noticeName" placeholder="제목을 입력하세요.">
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<textarea name="noticeContent" class="noticeContent" placeholder="내용을 입력하세요."></textarea>
								</td>
							</tr>
				        </table>
						
						<table class="imageInformation">
							<tr>
								<th colspan="2" class="table_title">이미지정보</th>
							</tr>
							<tr>
								<th>이미지등록</th>
								<td>
									<div class="image-wrapper">
										<div class="image-upload-container">
											<div class="image-preview-wrapper">
												<div class="image-preview" id="imagePreview">
													<img id="previewImg" src="" alt="이미지 미리보기" style="display: none;">
													<div class="no-image-text" id="noImageText">+</div>
												</div>
											</div>
											<div class="image-upload-controls">
												<input type="file" id="imageInput" accept="image/*" style="display: none;">
												<button type="button" class="btn-file-select" onclick="document.getElementById('imageInput').click()">파일 선택</button>
												<button type="button" class="btn-file-delete" onclick="deleteImage()">삭제</button>
											</div>
											<div class="image-info" id="imageInfo"></div>
										</div>
										<div class="image-information">권장이미지 : 500px * 500px / 5M 이하 / gif, png, jpg(jpeg)</div>
									</div>	
								</td>
							</tr>
						</table>
					</div>	
				</div>
				<div class="search-buttons">
		        	<button class="btn-submit">등록</button>
		        	<button class="btn-reset">취소</button>
				</div>
			</div>
		</div>
	</body>
</html>