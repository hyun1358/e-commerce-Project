package vo;

public class CartVO {
	private int product_id, cart_id, price, sale_price, quantity, user_idx, amount;
	private String company, product_name, image1;
	private int final_price, stock;
	private String is_visible, description;
	 public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
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
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getFinal_price() {
		return final_price;
	}

	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getCart_id() {
		return cart_id;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

}
