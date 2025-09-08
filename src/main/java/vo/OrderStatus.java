package vo;

public enum OrderStatus {
    N, // 정상
    C, // 결제취소
    R, RP, RC, RD, // 반품 관련
    E, EP, EC, ED, // 교환 관련
    F, FP, FC, FD; // 환불 관련

	//요청유형 - 반품관련
    public boolean isReturnStatus() {
        return this.name().startsWith("R");
    }

    //요청유형 - 교환관련
    public boolean isExchangeStatus() {
        return this.name().startsWith("E");
    }

    //요청유형 - 환불관련
    public boolean isRefundStatus() {
        return this.name().startsWith("F");
    }
    
    //처리상태 - 처리중
    public boolean isProcessing() {
        return this.name().endsWith("P");
    }

    //처리상태 - 거절 거부
    public boolean isRejected() {
        return this.name().endsWith("D");
    }

    //처리상태 - 완료
    public boolean isCompleted() {
        return this.name().endsWith("C");
    }
}
