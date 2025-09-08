package vo;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SearchReturnVO extends BaseSearchVO{
	private String refundStatus;
	private String processStatus;
	private String dateType;
	
	public String toQueryString() {
		StringBuilder sb = new StringBuilder();

		// BaseSearchVO 
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

		// SearchReturnVO 
		if (processStatus != null && !processStatus.isEmpty()) {
			sb.append("processStatus=").append(URLEncoder.encode(processStatus, StandardCharsets.UTF_8)).append("&");
		}
		if (refundStatus != null) {
			sb.append("refundStatus=").append(refundStatus).append("&");
		}
		if (dateType != null) {
			sb.append("dateType=").append(dateType).append("&");
		}
		// 筌띾뜆占쏙쭕占� & 占쎌젫椰꾬옙
		if (sb.length() > 0) {
			sb.setLength(sb.length() - 1);
		}

		return sb.toString();
	}
	
	public String getRefundStatus() {
		return refundStatus;
	}
	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	
	
}
