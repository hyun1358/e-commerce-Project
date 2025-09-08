package vo;

import org.springframework.web.multipart.MultipartFile;

public class ProductUploadVO {
	private int product_id, category_id, stock, price, sale_price, sales_volume;
	private String product_name, company, description;
	private MultipartFile[] images; // 업로드용
	private int final_price;
	private String regdate;
	private String is_visible;
	
	// 이미지 개별 경로 필드 이미지 매칭해서 가지고 오는거 
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	private String image5;
	private transient String[] imagePaths;

	private int parent_category_id;

	public int getParent_category_id() {
		return parent_category_id;
	}

	public void setParent_category_id(int parent_category_id) {
		this.parent_category_id = parent_category_id;
	}

	public void setImagePaths(String[] imagePaths) {
		this.imagePaths = imagePaths;

		if (imagePaths != null) {
			if (imagePaths.length > 0) this.image1 = imagePaths[0] != null ? imagePaths[0] : null;
			if (imagePaths.length > 1) this.image2 = imagePaths[1] != null ? imagePaths[1] : null;
			if (imagePaths.length > 2) this.image3 = imagePaths[2] != null ? imagePaths[2] : null;
			if (imagePaths.length > 3) this.image4 = imagePaths[3] != null ? imagePaths[3] : null;
			if (imagePaths.length > 4) this.image5 = imagePaths[4] != null ? imagePaths[4] : null;
		}
	}

	public String[] getImagePaths() {
		return imagePaths;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public String getImage5() {
		return image5;
	}

	public void setImage5(String image5) {
		this.image5 = image5;
	}

	public String getIs_visible() {
		return is_visible;
	}

	public void setIs_visible(String is_visible) {
		this.is_visible = is_visible;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
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

	public int getSales_volume() {
		return sales_volume;
	}

	public void setSales_volume(int sales_volume) {
		this.sales_volume = sales_volume;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public MultipartFile[] getImages() {
		return images;
	}

	public void setImages(MultipartFile[] images) {
		this.images = images;
	}

	public int getFinal_price() {
		return final_price;
	}

	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

}
