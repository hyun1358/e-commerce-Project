package vo;

public enum OrderStatus {
    N, // ����
    C, // �������
    R, RP, RC, RD, // ��ǰ ����
    E, EP, EC, ED, // ��ȯ ����
    F, FP, FC, FD; // ȯ�� ����

	//��û���� - ��ǰ����
    public boolean isReturnStatus() {
        return this.name().startsWith("R");
    }

    //��û���� - ��ȯ����
    public boolean isExchangeStatus() {
        return this.name().startsWith("E");
    }

    //��û���� - ȯ�Ұ���
    public boolean isRefundStatus() {
        return this.name().startsWith("F");
    }
    
    //ó������ - ó����
    public boolean isProcessing() {
        return this.name().endsWith("P");
    }

    //ó������ - ���� �ź�
    public boolean isRejected() {
        return this.name().endsWith("D");
    }

    //ó������ - �Ϸ�
    public boolean isCompleted() {
        return this.name().endsWith("C");
    }
}
