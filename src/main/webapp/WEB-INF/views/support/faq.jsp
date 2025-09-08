<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FAQ</title>
		<script>   	
    		var contextPath = "${pageContext.request.contextPath}";
		</script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/support/css/faq.css"/>
		<script src="${pageContext.request.contextPath}/resources/support/script/faq.js" defer></script>
	</head>
	
	<body>
		<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
		<div class="faq_container">
		    <h1 class="faq-title">FAQ</h1>
		    <div class="tab-container">
		        <a href="#" class="tab active">회원/멤버십</a>
		        <a href="#" class="tab">제품/이벤트</a>
		        <a href="#" class="tab">주문/결제</a>
		        <a href="#" class="tab">배송</a>
		        <a href="#" class="tab">교환/반품/취소</a>
		        <a href="#" class="tab">이용문의</a>
		        <a href="#" class="tab">시스템오류</a>
		    </div>
		    
		    <div id="content1" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">제품에 대한 문의는 어디로 하나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>제품 관련 문의는 Good Luck 고객센터(1544-9970)로 문의해 주세요.</p>
		                    <p>운영시간: 평일 09:00~18:00 (공휴일 제외)</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">가입한 ID(E-mail)를 찾고 싶어요.</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>로그인 페이지에서 'ID 찾기'를 통해 가입한 이메일을 확인할 수 있습니다.</p>
		                    <p>본인 인증 후 가입된 이메일 목록을 확인하실 수 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">회원가입 시 혜택이 있나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>네, 회원가입 시 다양한 혜택을 제공해 드립니다.</p>
		                    <p>신규 회원가입 쿠폰, 등급별 할인 혜택, 생일 쿠폰 등 다양한 혜택을 누리실 수 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">회원가입은 어떻게 하나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>메인 페이지 우측 상단의 '회원가입' 버튼을 통해 가입하실 수 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">계정의 ID는 무엇인가요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>계정의 ID는 이메일 주소입니다.</p>
		                    <p>회원가입 시 등록한 이메일을 ID로 사용하여 로그인하실 수 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">회원가입에 연령 제한이 있나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>네, 만 14세 이상부터 회원가입이 가능합니다.</p>
		                    <p>개인정보보호법에 따라 만 14세 미만의 경우 법정대리인의 동의가 필요하므로, 현재는 만 14세 이상만 가입 가능합니다.</p>
		                </div>
		            </div>
		        </div><!-- faq_list -->
		    </div><!-- content1 -->
		    
		    <!-- 제품/이벤트 탭 콘텐츠 -->
		    <div id="content2" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">신제품은 언제 출시되나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>신제품은 매달 첫째 주에 업데이트됩니다.</p>
		                    <p>새로운 제품 소식은 홈페이지와 SNS를 통해 확인하실 수 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">이벤트 참여는 어떻게 하나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>이벤트 페이지에서 원하시는 이벤트를 선택하여 참여하실 수 있습니다.</p>
		                    <p>각 이벤트마다 참여 방법이 다를 수 있으니 자세한 내용은 해당 이벤트 페이지를 확인해 주세요.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		    
		    <!-- 주문/결제 탭 콘텐츠 -->
		    <div id="content3" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">결제 방법은 어떤 것이 있나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>신용카드, 체크카드, 무통장입금, 휴대폰 결제, 간편결제(카카오페이, 네이버페이 등) 등 다양한 결제 방법을 제공하고 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">주문 내역은 어디서 확인할 수 있나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>로그인 후 마이페이지 > 주문내역에서 확인하실 수 있습니다.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		    
		    <!-- 배송 탭 콘텐츠 -->
		    <div id="content4" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">배송비는 얼마인가요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>기본 배송비는 3,000원이며, 5만원 이상 구매 시 무료 배송입니다.</p>
		                    <p>일부 제품 및 지역에 따라 배송비가 추가될 수 있습니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">배송 조회는 어떻게 하나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>마이페이지 > 주문내역에서 주문번호를 클릭하면 배송 조회가 가능합니다.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		    
		    <!-- 교환/반품/취소 탭 콘텐츠 -->
		    <div id="content5" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">교환/반품 신청 기간은 얼마인가요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>상품 수령일로부터 7일 이내에 교환/반품 신청이 가능합니다.</p>
		                    <p>제품 하자의 경우 30일 이내에 신청 가능합니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">주문 취소는 어떻게 하나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>마이페이지 > 주문내역에서 취소하실 주문을 선택하여 취소 신청을 하실 수 있습니다.</p>
		                    <p>단, 배송이 시작된 이후에는 취소가 어려울 수 있습니다.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		    
		    <!-- 이용문의 탭 콘텐츠 -->
		    <div id="content6" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">고객센터 운영 시간은 언제인가요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>고객센터는 평일 09:00~18:00까지 운영됩니다.</p>
		                    <p>주말 및 공휴일은 휴무입니다.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">1:1 문의는 어디서 하나요?</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>마이페이지 > 1:1 문의하기에서 문의 접수가 가능합니다.</p>
		                    <p>접수된 문의는 순차적으로 답변 드리고 있습니다.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		    
		    <!-- 시스템오류 탭 콘텐츠 -->
		    <div id="content7" class="tab-content">
		        <div class="faq-list">
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">결제 중 오류가 발생했어요.</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>결제 중 오류는 일시적인 네트워크 문제로 발생할 수 있습니다.</p>
		                    <p>잠시 후 다시 시도해보시고, 계속 문제가 발생한다면 고객센터로 문의해 주세요.</p>
		                </div>
		            </div>
		            
		            <div class="faq-item">
		                <div class="faq-question">
		                    <div class="question-left">
		                        <div class="category-icon">Q</div>
		                        <div class="question-text">웹사이트가 제대로 로딩되지 않아요.</div>
		                    </div>
		                    <div class="toggle-icon">+</div>
		                </div>
		                <div class="faq-answer">
		                    <p>브라우저 캐시를 삭제하거나 다른 브라우저로 접속을 시도해 보세요.</p>
		                    <p>지속적인 문제 발생 시 고객센터(1544-9970)로 문의 부탁드립니다.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		</div><!-- faq_container -->
		<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	</body>
</html>