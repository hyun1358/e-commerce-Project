package vo;

public class OrderListVO {
	private int user_idx, product_id, quantity, amount;
	private String order_id, status, order_date,image1, product_name;
	private String refund_status,refund_requested_at,note;
	private Integer review_id;
	private String is_visible;
	 // --- 기존 Getter/Setter ---
  public String getIs_visible() {
      return is_visible;
  }
  public void setIs_visible(String is_visible) {
      this.is_visible = is_visible;
  }

  // --- JSP에서 쓰기 좋은 Boolean getter ---
  public boolean isVisible() {
      return is_visible != null && is_visible.trim().equalsIgnoreCase("y");
  }
	
	public Integer getReview_id() {
		return review_id;
	}
	public void setReview_id(Integer review_id) {
		this.review_id = review_id;
	}
	public String getRefund_status() {
		return refund_status;
	}
	public void setRefund_status(String refund_status) {
		this.refund_status = refund_status;
	}
	public String getRefund_requested_at() {
		return refund_requested_at;
	}
	public void setRefund_requested_at(String refund_requested_at) {
		this.refund_requested_at = refund_requested_at;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	
	/*
	 * String shipping_phone, shipping_name, zipcode, address1, address2,
	 * refund_status, request, cardname, cardnumber,;
	 */
	

	
	
}
