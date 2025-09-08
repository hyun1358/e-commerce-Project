package vo;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SearchCustomerVO extends BaseSearchVO {

	private String customerStatus;
	private Integer customerStatusInteger; 

	public String toQueryString() {
		StringBuilder sb = new StringBuilder();

		// BaseSearchVO �븘�뱶�뱾
		if (getSearchCategory() != null && !getSearchCategory().isEmpty()) {
			sb.append("searchCategory=").append(URLEncoder.encode(getSearchCategory(), StandardCharsets.UTF_8))
					.append("&");
		}
		if (getSearchKeyword() != null && !getSearchKeyword().isEmpty()) {
			sb.append("searchKeyword=").append(URLEncoder.encode(getSearchKeyword(), StandardCharsets.UTF_8))
					.append("&");
		}
		if (getDateStart() != null && !getDateStart().isEmpty()) {
			sb.append("dateStart=").append(URLEncoder.encode(getDateStart(), StandardCharsets.UTF_8)).append("&");
		}
		if (getDateEnd() != null && !getDateEnd().isEmpty()) {
			sb.append("dateEnd=").append(URLEncoder.encode(getDateEnd(), StandardCharsets.UTF_8)).append("&");
		}

		if (getSortOption() != null && !getSortOption().isEmpty()) {
			sb.append("sortOption=").append(URLEncoder.encode(getSortOption(), StandardCharsets.UTF_8)).append("&");
		}

		// SearchCustomerVO �븘�뱶�뱾
		if (customerStatus != null && !customerStatus.isEmpty()) {
			sb.append("customerStatus=").append(URLEncoder.encode(customerStatus, StandardCharsets.UTF_8)).append("&");
		}
		if (customerStatusInteger != null) {
			sb.append("customerStatusInteger=").append(customerStatusInteger).append("&");
		}
		// 留덉�留� & �젣嫄�
		if (sb.length() > 0) {
			sb.setLength(sb.length() - 1);
		}

		return sb.toString();
	}
	

	public String getCustomerStatus() {
		return customerStatus;
	}

	public void setCustomerStatus(String customerStatus) {
		this.customerStatus = customerStatus;
	}


	public Integer getCustomerStatusInteger() {
		return customerStatusInteger;
	}


	public void setCustomerStatusInteger(Integer customerStatusInteger) {
		this.customerStatusInteger = customerStatusInteger;
	}

	
}
