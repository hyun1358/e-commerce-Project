<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새로운 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/homepage/css/main-page.css" />

<script
	src="${pageContext.request.contextPath}/resources/homepage/script/main-page.js"></script>
<script src="${pageContext.request.contextPath}/resources/products/script/product_to_cart.js"></script>
<script>
    // contextPath를 정의하고 initializeCartActions를 호출합니다.
    var contextPath = "${pageContext.request.contextPath}";
    if (typeof initializeCartActions === 'function') {
        initializeCartActions(contextPath);
    }
</script>
</head>

<body data-context="${pageContext.request.contextPath}">
	<jsp:include page="homeHeader.jsp"></jsp:include>
	<jsp:include page='banner.jsp'></jsp:include>
	<div class="main-body-container">
		<div class='quickmenu-list'>
			<a href="${pageContext.request.contextPath}/category?category_id=${10}"
				class="quickmenu-link">
				<div class="quickmenu-icon">
					<img
						src='${pageContext.request.contextPath}/resources/homepage/image/Icon-laptop.png'
						alt='노트북 이미지'>
				</div> <span class="quickmenu-name">노트북</span>
			</a> <a href="${pageContext.request.contextPath}/category?category_id=${11}"
				class="quickmenu-link">
				<div class="quickmenu-icon">
					<img
						src='${pageContext.request.contextPath}/resources/homepage/image/Icontelevision.png'>
				</div> <span class="quickmenu-name">TV</span>
			</a> <a
				href="${pageContext.request.contextPath}/category?category_id=${12}"
				class="quickmenu-link">
				<div class="quickmenu-icon">
					<img
						src='${pageContext.request.contextPath}/resources/homepage/image/Iconrefrigerato.png'
						alt="냉장고 이미지" />
				</div> <span class="quickmenu-name">냉장고</span>
			</a> <a
				href="${pageContext.request.contextPath}/category?category_id=${13}"
				class="quickmenu-link">
				<div class="quickmenu-icon">
					<img
						src='${pageContext.request.contextPath}/resources/homepage/image/Iconair-conditioner.png'
						alt="에어컨 이미지" />
				</div> <span class="quickmenu-name">에어컨</span>
			</a> <a href="${pageContext.request.contextPath}/category?category_id=${14}" class="quickmenu-link">
				<div class="quickmenu-icon">
					<%-- <img src='${pageContext.request.contextPath}/homepage/image/Iconwashing-machine.png'> --%>
					<img
						src='${pageContext.request.contextPath}/resources/homepage/image/Icon-washer.png'>
				</div> <span class="quickmenu-name">세탁기</span>
			</a>
		</div>
	</div>

	<div>
		<div class="basket_event">
			<a href="${pageContext.request.contextPath}/category?category_id=${10}" class="event_banner">
				<div class="event_image">
					<img src="${pageContext.request.contextPath}/resources/homepage/image/event_banner.png" alt="특가 행사" />
				</div>
				<div class="event_text">
					<span class="event_text1">8월 11일 (월) 오전 9시</span><br> 
					<span class="event_text2">최신 가전 특가 행사</span><br>
					<span class="event_text3">바로가기 ></span>
				</div>
			</a>
		</div>
	</div>

	<div class='best-container'>
		<div class='best-title'>
			<img
				src='${pageContext.request.contextPath}/resources/homepage/image/Iconcrown2.png'>
			<h2>베스트 상품</h2>
		</div>
  <div class="slider-area" style="position: relative;">
		<button class="slide-btn prev-btn" id="prevBtn" aria-label="이전 상품 보기">&lt;</button>
		<div class="best-slider-wrapper" style="position: relative;">
			<!-- <button class="slide-btn prev-btn" aria-label="이전 상품 보기">&lt;</button> -->

			<div class="best-slider" id="bestSlider">
				<c:forEach var="vo" items="${ best_list }" varStatus="status">
					<div class='best-card'>
						<div class="rank-number">${status.count}</div>
						<div>
							<a href='product_detail.do?product_id=${vo.product_id}'
								class='image-link'> <img
								src="${pageContext.request.contextPath}/resources/${vo.image1}"
								alt='제품사진' />
								<p class="product-name">${ vo.product_name }</p>
							</a>
						</div>
						<div class="product-price">
							<fmt:formatNumber value="${vo.final_price}" type="number" />
							원
						</div>
						<div>
							<c:choose>
								<c:when test="${not empty user}">
									<input type="button" value="담기"
										onclick="addCart(${vo.product_id}, ${user.user_idx}); return false;">
								</c:when>
								<c:otherwise>
									<input type="button" value="담기"
										onclick="addGuestCart(${vo.product_id}); return false;">
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>

				<!-- 복제 -->
				<c:forEach var="vo" items="${ best_list }" varStatus="status">
					<div class='best-card'>
						<div class="rank-number">${status.count}</div>
						<div>
							<a href='product_detail.do?product_id=${vo.product_id}'
								class='image-link'> <img
								src="${pageContext.request.contextPath}/resources/${vo.image1}"
								alt='제품사진' />
								<p class="product-name">${ vo.product_name }</p>
							</a>
						</div>
						<div class="product-price">
							<fmt:formatNumber value="${vo.final_price}" type="number" />
							원
						</div>
						<div>
							<c:choose>
								<c:when test="${not empty user}">
									<input type="button" value="담기"
										onclick="addCart(${vo.product_id}, ${user.user_idx}); return false;">
								</c:when>
								<c:otherwise>
									<input type="button" value="담기"
										onclick="addGuestCart(${vo.product_id}); return false;">
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</div>
</div>
			<button class="slide-btn next-btn" id="nextBtn" aria-label="다음 상품 보기">&gt;</button>
		</div>
	</div>


	<div class='discount-container'>
		<div class='today-time'>
			<h2>일일 특가</h2>
			<div class="timer-box">

				<h2 id="timer">00:00:00</h2>
				<img
					src="${pageContext.request.contextPath}/resources/homepage/image/Iconclock.gif"
					alt="시계 이미지" />
			</div>
		</div>
		<div class="today-cards-wrapper">
			<div class='today-card'>
				<div>
					<a
						href='${pageContext.request.contextPath}/product_detail.do?product_id=${model1.product_id}'
						class='image-link'> <img
						src='${pageContext.request.contextPath}/resources/${model1.image1}'
						alt='제품사진' />
						<p class="product-name">${model1.product_name}</p>
					</a>
				</div>
				<div class="product-price">
					<span class="discount-rate">${model1.discount_percent}<span class="percent">%</span></span>
				    <span class="discount-price"><fmt:formatNumber value="${model1.final_price}" type="number" pattern="#,###" /><span class="discount-won">원</span></span>			    
				    <span class="original-price"><fmt:formatNumber value="${model1.price}" type="number" pattern="#,###" /><span class="original-won">원</span></span>
				</div>
				<div>
					<c:choose>
						<c:when test="${not empty user}">
							<input type='button' value='담기'
								onclick="addCart(${model1.product_id}, ${user.user_idx}); return false;">
						</c:when>
						<c:otherwise>
							<input type='button' value='담기'
								onclick="addGuestCart(${model1.product_id}); return false;">
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="today-cards-wrapper">
			<div class='today-card'>
				<div>
					<a
						href='${pageContext.request.contextPath}/product_detail.do?product_id=${model2.product_id}'
						class='image-link'> <img
						src='${pageContext.request.contextPath}/resources/${model2.image1}'
						alt='제품사진' />
						<p class="product-name">${model2.product_name}</p>
					</a>
				</div>
				<div class="product-price">
					<span class="discount-rate">${model2.discount_percent}<span class="percent">%</span></span>
				    <span class="discount-price"><fmt:formatNumber value="${model2.final_price}" type="number" pattern="#,###" /><span class="discount-won">원</span></span>			    
				    <span class="original-price"><fmt:formatNumber value="${model2.price}" type="number" pattern="#,###" /><span class="original-won">원</span></span>
				</div>
				<div>
					<c:choose>
						<c:when test="${not empty user}">
							<input type='button' value='담기'
								onclick="addCart(${model2.product_id}, ${user.user_idx}); return false;">
						</c:when>
						<c:otherwise>
							<input type='button' value='담기'
								onclick="addGuestCart(${model2.product_id}); return false;">
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>



		<div id="blckSn-15090" data-type="PC_Banner_Brand"
		class="c-lazyloaded c-motion-up"
		style="margin-top: 0px; margin-bottom: 0px;">
		<div class="c-list">
			<ul class="c-list__container">
				<li class="c-list__item">
					<div class="c-banner">
						<p class="c-banner__img">
							<a href="${pageContext.request.contextPath}/category?category_id=${12}" data-log-actionid-area="today_brand_ad"
								data-log-actionid-label="big_banner1" data-is-send-log="true">
								<img
								src="${pageContext.request.contextPath}/resources/homepage/image/c-refrigerator.png"
								alt="Bespoke AI 냉장고">
							</a>
						</p>
					</div>
				</li>
				<li class="c-list__item">
					<div class="c-banner">
						<p class="c-banner__img">
							<a href="${pageContext.request.contextPath}/category?category_id=${11}" data-log-actionid-area="today_brand_ad"
								data-log-actionid-label="banner1" data-is-send-log="true"> <img
								src="${pageContext.request.contextPath}/resources/homepage/image/c-oled_tv.png"
								alt="올레드 으뜸 페스타">
							</a>
						</p>
					</div>
				</li>
				<li class="c-list__item">
					<div class="c-banner">
						<p class="c-banner__img">
							<a href="${pageContext.request.contextPath}/category?category_id=${10}" data-log-actionid-area="today_brand_ad"
								data-log-actionid-label="banner2" data-is-send-log="true"> <img
								src="${pageContext.request.contextPath}/resources/homepage/image/c-notebook2.png"
								alt="LG 노트북">
							</a>
						</p>
					</div>
				</li>
				<li class="c-list__item">
					<div class="c-banner">
						<p class="c-banner__img">
							<a href="${pageContext.request.contextPath}/category?category_id=${13}" data-log-actionid-area="today_brand_ad"
								data-log-actionid-label="banner3" data-is-send-log="true"> <img
								src="${pageContext.request.contextPath}/resources/homepage/image/c-bespoke.png"
								alt="Bespoke AI 에어컨">
							</a>
						</p>
					</div>
				</li>
				<li class="c-list__item">
					<div class="c-banner">
						<p class="c-banner__img">
							<a href="${pageContext.request.contextPath}/category?category_id=${14}" data-log-actionid-area="today_brand_ad"
								data-log-actionid-label="banner4" data-is-send-log="true"> <img
								src="${pageContext.request.contextPath}/resources/homepage/image/c-washer.png"
								alt="Bescope AI 세탁기">
							</a>
						</p>
					</div>
				</li>
				<li class="c-list__item">
					<div class="c-banner">
						<p class="c-banner__img">
							<a href="#" data-log-actionid-area="today_brand_ad"
								data-log-actionid-label="banner3" data-is-send-log="true"> <img
								src="${pageContext.request.contextPath}/resources/homepage/image/c-galaxy_watch.png"
								alt="삼성 갤럭시 워치">
							</a>
						</p>
					</div>
				</li>
			</ul>
		</div>
	</div>

	
	<section class="content-section animate-on-scroll">
        <header class="section-header">
            <h2 class="header-text">파트너</h2>
        </header>
        <div class="partners-container">
            <ul class="partners-list">
                <li class="main-mall__item"><a href="http://www.gmarket.co.kr/index.asp?jaehuid=200002657" target="_blank"><img src="//img.danawa.com/cmpny_info/images/EE128_logo.gif" alt="지마켓"></a></li>
                <li class="main-mall__item"><a href="https://link.coupang.com/re/PCSDANAWAPCHOME" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TP40F_logo.gif" alt="쿠팡"></a></li>
                <li class="main-mall__item"><a href="http://banner.auction.co.kr/bn_redirect.asp?ID=BN00011729" target="_blank"><img src="//img.danawa.com/cmpny_info/images/EE715_logo.gif" alt="옥션"></a></li>
                <li class="main-mall__item"><a href="http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&amp;tid=1000002531" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TH201_logo.gif" alt="11번가"></a></li>
                <li class="main-mall__item"><a href="https://www.lge.co.kr/home?channel_code=100501" target="_blank"><img src="https://img.danawa.com/cmpny_info/images/TW326B_logo.gif" alt="LG전자"></a></li>
                <li class="main-mall__item"><a href="http://www.e-himart.co.kr/index.jsp?fromShop=dnw" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TJ418_logo.gif" alt="하이마트"></a></li>
                <li class="main-mall__item"><a href="https://www.etlandmall.co.kr/pc/main/index.do?chlCode=A072" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TJ918_logo.gif" alt="전자랜드"></a></li>
                <li class="main-mall__item"><a href="http://www.lotteimall.com/coop/affilGate.lotte?chl_no=23" target="_blank"><img src="//img.danawa.com/cmpny_info/images/ED903_logo.gif" alt="롯데홈쇼핑"></a></li>
                <li class="main-mall__item"><a href="http://www.ssg.com?ckwhere=danawa_direct" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TN118_logo.gif" alt="SSG"></a></li>
                
                <li class="main-mall__item"><a href="http://display.cjonstyle.com/p/homeTab/main?infl_cd=I0651&amp;utm_medium=mallname&amp;utm_source=danawa" target="_blank"><img src="//img.danawa.com/cmpny_info/images/ED909_logo.gif" alt="CJ온스타일"></a></li>
				<li class="main-mall__item"><a href="http://with.gsshop.com/jsp/jseis_withLGeshop.jsp?media=Qm&amp;gourl=http://www.gsshop.com/index.gs" target="_blank"><img src="//img.danawa.com/cmpny_info/images/ED908_logo.gif" alt="GSSHOP"></a></li>
				<li class="main-mall__item"><a href="https://www.lotteon.com/p/display/main/lotteon?mall_no=1&amp;ch_no=100071&amp;ch_dtl_no=1000227" target="_blank"><img src="//img.danawa.com/upload_img/av_keyvisual_20210908_10:01:18.jpg" alt="롯데ON"></a></li>
				<li class="main-mall__item"><a href="https://hmall.com/pd/dpl/index?ReferCode=250&amp;utm_source=danawa&amp;utm_medium=cps&amp;utm_campaign=sale" target="_blank"><img src="//img.danawa.com/cmpny_info/images/ED907_logo.gif" alt="Hmall"></a></li>
				<li class="main-mall__item"><a href="http://emart.ssg.com/main.ssg?ckwhere=danawa&amp;sid=dn001" target="_blank"><img src="//img.danawa.com/cmpny_info/images/EE311_logo.gif" alt="이마트몰"></a></li>
				<li class="main-mall__item"><a href="https://www.skstoa.com/index?mediaCode=EP16" target="_blank"><img src="https://img.danawa.com/cmpny_info/images/TSB275_logo.gif" alt="SK스토아"></a></li>
				<li class="main-mall__item"><a href="http://www.thehyundai.com/front/shNetworkShop.thd?NetworkShop=Html&amp;ReferCode=030&amp;utm_source=danawa&amp;utm_medium=cps&amp;utm_term=danawa&amp;" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TP90D_logo.gif" alt="더현대닷컴"></a></li>
				<li class="main-mall__item"><a href="https://www.lotteon.com/p/display/main/ellotte?mall_no=2&amp;ch_no=100072&amp;ch_dtl_no=1000228" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TLC16_logo.gif" alt="롯데백화점"></a></li>
				<li class="main-mall__item"><a href="http://shinsegaemall.ssg.com?ckwhere=s_danawa" target="_blank"><img src="//img.danawa.com/cmpny_info/images/ED901_logo.gif" alt="신세계몰"></a></li>
				<li class="main-mall__item"><a href="http://www.nsmall.com/jsp/site/gate.jsp?co_cd=430" target="_blank"><img src="//img.danawa.com/cmpny_info/images/ED904_logo.gif" alt="Nsmall"></a></li>
				<li class="main-mall__item"><a href="https://affiliate.homeplus.co.kr/external/bridge?channelId=1000018&amp;targetUrl=https%3a%2f%2ffront.homeplus.co.kr" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TK316_logo.gif" alt="홈플러스"></a></li>
				<li class="main-mall__item"><a href="https://www.gongyoungshop.kr/gate/selectAliance.do?alcLnkCd=dnwpcs" target="_blank"><img src="//img.danawa.com/cmpny_info/images/logo_gongyoung.gif" alt="공영쇼핑"></a></li>
				<li class="main-mall__item"><a href="http://www.hnsmall.com/channel/channel.do?channel_code=20039" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TLB17_logo.gif" alt="홈앤쇼핑"></a></li>
				<li class="main-mall__item"><a href="http://www.shinsegaetvshopping.com?inMediaCode=MC04&amp;ckwhere=danawaetc" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TRB03_logo.gif" alt="신세계TV쇼핑"></a></li>
				<li class="main-mall__item"><a href="https://ohou.se/store?utm_source=danawa_shop&amp;utm_medium=cpc&amp;utm_campaign=uc_web-all-web_all-danawa_shop&amp;affect_type=UtmUrl" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TU710C_logo.gif" alt="오늘의 집"></a></li>
				<li class="main-mall__item"><a href="https://store.musinsa.com/?utm_source=danawa&amp;utm_medium=sh&amp;source=DANAWA" target="_blank"><img src="https://img.danawa.com/cmpny_info/images/musinsa_72x32.gif" alt="무신사"></a></li>
				<li class="main-mall__item"><a href="http://mall.hanssem.com/interface/danawa.do?PARTNERID=hanssem_partner_01&amp;URL=http://mall.hanssem.com/" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TNB05_logo.gif" alt="한샘"></a></li>
				<li class="main-mall__item"><a href="https://www.tstation.com/?epChl=DANAWA&amp;epChlDtl=2" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TTB3F7_logo.gif" alt="티스테이션"></a></li>
				<li class="main-mall__item"><a href="https://mart.baemin.com/campaign/landing/cGoArBmVUKektFWm" target="_blank"><img src="https://img.danawa.com/cmpny_info/images/TWB192_logo.gif" alt="배민상회"></a></li>
				<li class="main-mall__item"><a href="https://www.dongwonmall.com/index.do?&amp;utm_source=danawa&amp;utm_medium=display&amp;utm_campaign=main&amp;nrCoId=w2code" target="_blank"><img src="https://img.danawa.com/cmpny_info/images/TSBB7_logo.gif" alt="동원몰"></a></li>
				<li class="main-mall__item"><a href="https://www.lfmall.co.kr/app/exhibition/menu/501?af=DN02" target="_blank"><img src="//img.danawa.com/cmpny_info/images/TXB15E_logo.gif" alt="LFmall"></a></li>             
            </ul>
        </div>
    </section>
	

	<jsp:include page="homeFooter.jsp"></jsp:include>

</body>
</html>