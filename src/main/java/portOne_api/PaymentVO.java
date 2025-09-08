package portOne_api;

public class PaymentVO 
{
    private String imp_uid;        // 포트원 결제 고유번호
    private String merchant_uid;   // 가맹점 주문번호
    private String status;
    // 오류 메시지

    public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	// getters and setters
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
}
