package vo;

public class ProductListViewVO {
	    private int product_id;
	    private String product_name;
	    private String company;
	    private int price, sale_price, stock;
	    private String is_visible, regdate;

	    private int category_id;
	    private int parent_category_id;
	    private String parent_category_name;
	    private String child_category_name;
		public int getProduct_id() {
			return product_id;
		}
		public void setProduct_id(int product_id) {
			this.product_id = product_id;
		}
		public String getProduct_name() {
			return product_name;
		}
		public void setProduct_name(String product_name) {
			this.product_name = product_name;
		}
		public String getCompany() {
			return company;
		}
		public void setCompany(String company) {
			this.company = company;
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
		public int getStock() {
			return stock;
		}
		public void setStock(int stock) {
			this.stock = stock;
		}
		public String getIs_visible() {
			return is_visible;
		}
		public void setIs_visible(String is_visible) {
			this.is_visible = is_visible;
		}
		public String getRegdate() {
			return regdate;
		}
		public void setRegdate(String regdate) {
			this.regdate = regdate;
		}
		public int getCategory_id() {
			return category_id;
		}
		public void setCategory_id(int category_id) {
			this.category_id = category_id;
		}
		public int getParent_category_id() {
			return parent_category_id;
		}
		public void setParent_category_id(int parent_category_id) {
			this.parent_category_id = parent_category_id;
		}
		public String getParent_category_name() {
			return parent_category_name;
		}
		public void setParent_category_name(String parent_category_name) {
			this.parent_category_name = parent_category_name;
		}
		public String getChild_category_name() {
			return child_category_name;
		}
		public void setChild_category_name(String child_category_name) {
			this.child_category_name = child_category_name;
		}

	    // + Getter/Setter
	    
	    
}
