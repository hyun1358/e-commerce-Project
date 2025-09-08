package vo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class PaymentVO 
{
    @JsonProperty("status")
    private String status;
    
    @JsonProperty("imp_uid")
    private String imp_uid;

    @JsonProperty("pay_method")
    private String pay_method;

    @JsonProperty("merchant_uid")
    private String merchant_uid;

    @JsonProperty("name")
    private String product_name;

    @JsonProperty("paid_amount")
    private Integer paid_amount;

    @JsonProperty("currency")
    private String currency;   //
    
    @JsonProperty("card_name")
    private String card_name;

    @JsonProperty("card_number")
    private String card_number;
    
    @JsonProperty("paid_at")
    private String paid_at;
    
    @JsonProperty("buyer_name")
    private String buyer_name;
    
    @JsonProperty("buyer_tel")
    private String buyer_tel;
    
    @JsonProperty("buyer_addr")
    private String buyer_addr;
    
    @JsonProperty("buyer_postcode")
    private String buyer_postcode;
    
    @JsonProperty("receipt_url")
    private String receipt_url;
    
    @JsonProperty("deliveryRequest")
    private String deliveryRequest;
    
    @JsonProperty("products")
    private List<Product> products;
    
    private String productName;
    
	private Integer product_id;

    private Integer quantity;
    
    private Integer amount;
    

    
    public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
    
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public String getDeliveryRequest() {
		return deliveryRequest;
	}

	public void setDeliveryRequest(String deliveryRequest) {
		this.deliveryRequest = deliveryRequest;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public String getPay_method() {
		return pay_method;
	}

	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public Integer getPaid_amount() {
		return paid_amount;
	}

	public void setPaid_amount(Integer paid_amount) {
		this.paid_amount = paid_amount;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getCard_name() {
		return card_name;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

	public String getCard_number() {
		return card_number;
	}

	public void setCard_number(String card_number) {
		this.card_number = card_number;
	}

	public String getPaid_at() {
		return paid_at;
	}

	public void setPaid_at(String paid_at) {
		this.paid_at = paid_at;
	}

	public String getBuyer_name() {
		return buyer_name;
	}

	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}

	public String getBuyer_tel() {
		return buyer_tel;
	}

	public void setBuyer_tel(String buyer_tel) {
		this.buyer_tel = buyer_tel;
	}

	public String getBuyer_addr() {
		return buyer_addr;
	}

	public void setBuyer_addr(String buyer_addr) {
		this.buyer_addr = buyer_addr;
	}

	public String getBuyer_postcode() {
		return buyer_postcode;
	}

	public void setBuyer_postcode(String buyer_postcode) {
		this.buyer_postcode = buyer_postcode;
	}

	public String getReceipt_url() {
		return receipt_url;
	}

	public void setReceipt_url(String receipt_url) {
		this.receipt_url = receipt_url;
	}
    
	public static class Product 
	{
		@JsonProperty("productName")
		private String productName;
		
		@JsonProperty("productId")
        private Integer product_id;

        @JsonProperty("quantity")
        private Integer quantity;
        
        @JsonProperty("amount")
        private Integer amount;

        
        public String getProductName() {
			return productName;
		}

		public void setProductName(String productName) {
			this.productName = productName;
		}
        
		public Integer getAmount() {
			return amount;
		}

		public void setAmount(Integer amount) {
			this.amount = amount;
		}

		public Integer getProduct_id() {
			return product_id;
		}

		public void setProduct_id(Integer product_id) {
			this.product_id = product_id;
		}

		public Integer getQuantity() {
			return quantity;
		}

		public void setQuantity(Integer quantity) { 
			this.quantity = quantity;
		}

    }
    
}
