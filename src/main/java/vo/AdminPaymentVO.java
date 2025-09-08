package vo;

public class AdminPaymentVO {
	private int payment_id; // PK
	private String imp_uid; // 아임포트 결제 고유 ID
	private String merchant_uid; // 주문 ID (order_id)

	private String pay_method; // 결제 수단 (card, point 등)
	private String currency; // 통화(KRW, USD 등)
	private String paid_at; // 결제 일시 (timestamp 또는 String)

	private String card_name; // 카드사명
	//private String card_number; // 마스킹된 카드번호

	//private String buyer_name; // 구매자명
	//private String buyer_tel; // 전화번호
	//private String buyer_addr; // 주소
	//private String buyer_postcode; // 우편번호
	//private String deliveryrequest; // 배송 요청사항
	
	//private String status; // 상태(paid, cancelled 등)
	private int total_count_paid;     // 결제 완료된 상품 수량
	private int total_count_cancelled; // 결제 취소된 상품 수량
	private int total_paid_amount;       // 결제 완료 금액 합계
	private int total_cancelled_amount;  // 결제 취소 금액 합계
	
	public int getTotal_count_paid() {
		return total_count_paid;
	}

	public void setTotal_count_paid(int total_count_paid) {
		this.total_count_paid = total_count_paid;
	}

	public int getTotal_count_cancelled() {
		return total_count_cancelled;
	}

	public void setTotal_count_cancelled(int total_count_cancelled) {
		this.total_count_cancelled = total_count_cancelled;
	}

	public int getTotal_paid_amount() {
		return total_paid_amount;
	}

	public void setTotal_paid_amount(int total_paid_amount) {
		this.total_paid_amount = total_paid_amount;
	}

	public int getTotal_cancelled_amount() {
		return total_cancelled_amount;
	}

	public void setTotal_cancelled_amount(int total_cancelled_amount) {
		this.total_cancelled_amount = total_cancelled_amount;
	}

	private String receipt_url; // 영수증 URL

	public int getPayment_id() {
		return payment_id;
	}

	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}

	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public String getPay_method() {
		return pay_method;
	}

	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getPaid_at() {
		return paid_at;
	}

	public void setPaid_at(String paid_at) {
		this.paid_at = paid_at;
	}

	public String getCard_name() {
		return card_name;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

	public String getReceipt_url() {
		return receipt_url;
	}

	public void setReceipt_url(String receipt_url) {
		this.receipt_url = receipt_url;
	}


}
