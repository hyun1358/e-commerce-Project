package vo;

public class BaseSearchVO {
	private String searchCategory;
	private String searchKeyword;
	private String dateStart;
	private String dateEnd;
	private String sortOption; // "latest", "priceAsc", "priceDesc" �벑
	
	
	public String getSortOption() {
		return sortOption;
	}

	public void setSortOption(String sortOption) {
		this.sortOption = sortOption;
	}

	public String getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}


	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}

}
