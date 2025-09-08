package vo;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SearchProductVO extends BaseSearchVO {
	private String parentCategoryId;
	private String childCategoryId;

	private String productStatus;
	private String stockStatus; 

	private boolean allCategory;

	public boolean isAllCategory() {
		return allCategory;
	}

	public void setAllCategory(boolean allCategory) {
		this.allCategory = allCategory;
	}

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

		// SearchProductVO �븘�뱶�뱾
		if (parentCategoryId != null && !parentCategoryId.isEmpty()) {
			sb.append("parentCategoryId=").append(URLEncoder.encode(parentCategoryId, StandardCharsets.UTF_8))
					.append("&");
		}
		if (childCategoryId != null && !childCategoryId.isEmpty()) {
			sb.append("childCategoryId=").append(URLEncoder.encode(childCategoryId, StandardCharsets.UTF_8))
					.append("&");
		}
		if (productStatus != null && !productStatus.isEmpty()) {
			sb.append("productStatus=").append(URLEncoder.encode(productStatus, StandardCharsets.UTF_8)).append("&");
		}
		if (stockStatus != null && !stockStatus.isEmpty()) {
			sb.append("stockStatus=").append(URLEncoder.encode(stockStatus, StandardCharsets.UTF_8)).append("&");
		}

		// 留덉�留� & �젣嫄�
		if (sb.length() > 0) {
			sb.setLength(sb.length() - 1);
		}

		return sb.toString();
	}


	public String getStockStatus() {
		return stockStatus;
	}

	public void setStockStatus(String stockStatus) {
		this.stockStatus = stockStatus;
	}

	public String getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(String parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}

	public String getChildCategoryId() {
		return childCategoryId;
	}

	public void setChildCategoryId(String childCategoryId) {
		this.childCategoryId = childCategoryId;
	}

	public String getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(String productStatus) {
		this.productStatus = productStatus;
	}

}
