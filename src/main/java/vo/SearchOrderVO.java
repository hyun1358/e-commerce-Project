package vo;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SearchOrderVO extends BaseSearchVO {
	private String orderStatus;

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String toQueryString() {
		StringBuilder sb = new StringBuilder();

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

		if (orderStatus != null && !orderStatus.isEmpty()) {
			sb.append("orderStatus=").append(URLEncoder.encode(getSortOption(), StandardCharsets.UTF_8)).append("&");
		}
		if (sb.length() > 0) {
			sb.setLength(sb.length() - 1);
		}
		
		return sb.toString();

	}

}
