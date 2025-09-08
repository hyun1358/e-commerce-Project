package vo;

import java.util.List;

public class ReturnOrderIdsProductIdsVO {
	private List<String> orderIds;
	private List<Integer> productIds;
	
	public List<String> getOrderIds() {
		return orderIds;
	}
	public void setOrderIds(List<String> orderIds) {
		this.orderIds = orderIds;
	}
	public List<Integer> getProductIds() {
		return productIds;
	}
	public void setProductIds(List<Integer> productIds) {
		this.productIds = productIds;
	}
	
}
