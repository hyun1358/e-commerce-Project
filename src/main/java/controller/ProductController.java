package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale.Category;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Paging;
import dao.CategoryDAO;
import dao.ProductsDAO;
import dao.ReviewDAO;
import vo.LaptopSpecVO;
import vo.ProductVO;
import vo.ReviewVO;

@Controller
public class ProductController {
	ProductsDAO products_dao;
	ReviewDAO review_dao;
	CategoryDAO category_dao;

	public void setCategory_dao(CategoryDAO category_dao) {
		this.category_dao = category_dao;
	}

	public void setProducts_dao(ProductsDAO products_dao) {
		this.products_dao = products_dao;
	}

	public void setReview_dao(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}

	@RequestMapping("/product_detail.do")
	public String laptop_detail(Model model, @RequestParam(defaultValue = "1") int page, int product_id) 
	{
		int blockList = 3;
		int blockPage = 5;

		int review_cnt = review_dao.review_cnt(product_id);

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<ReviewVO> list = review_dao.selectPaging(product_id, startRow, endRow);
		// 리스트 null 처리 (빈 리스트로 초기화)
		if (list == null) 
		{
			list = new ArrayList<>();
		}

		ProductVO vo = products_dao.select_one(product_id);
		double review_avg = review_dao.review_avg(product_id);
		int ratingInt = (int) Math.round(review_avg);

		String pageUrl = "product_detail.do";
		String searchParam = "product_id=" + product_id;
		String pagingHtml = Paging.getPaging(pageUrl, page, review_cnt, searchParam, blockList, blockPage);
		
		System.out.println(vo.getImage1());
		System.out.println(vo.getImage2());
		
		model.addAttribute("vo", vo);
		model.addAttribute("review_list", list);
		model.addAttribute("review_cnt", review_cnt);
		model.addAttribute("review_avg", review_avg);
		model.addAttribute("ratingInt", ratingInt);
		model.addAttribute("paging_html", pagingHtml);
		
		
		return "products/product_details";
	}
	
	@RequestMapping("/revie_fiter")
	@ResponseBody
	public Map<String, Object> product_detail_review_filter(Model model,
			@RequestParam(defaultValue = "1") int page,
			int product_id, 
			@RequestParam(defaultValue = "newest") String sort)
	{
		int blockList = 3;
		int blockPage = 5;
		
		int review_cnt = review_dao.review_cnt(product_id);

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;
		
		String pageUrl = "revie_fiter";
		String searchParam = "product_id=" + product_id;
		
		System.out.println("들어옴" + product_id);
		
		
		List<ReviewVO> list = review_dao.select_filter_Paging(product_id, startRow, endRow, sort);
		if(list == null || list.size()==0)
		{
			list = new ArrayList<ReviewVO>();
		}
		
		String pagingHtml = Paging.getPaging(pageUrl, page, review_cnt, searchParam, blockList, blockPage);
		ProductVO vo = products_dao.select_one(product_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("review_list", list);
		map.put("pagingHtml", pagingHtml);
		map.put("vo", vo);
		return map;
	}

	@RequestMapping(value = "/product/specs", method = RequestMethod.POST)
	@ResponseBody
	public List<LaptopSpecVO> getProductSpecs(@RequestBody List<Integer> product_id) {
		return products_dao.laptop_spec(product_id);
	}

	@RequestMapping("/search")
	public String search(@RequestParam("keyword") String keyword, Model model) {
		List<ProductVO> result = products_dao.searchProducts(keyword);
		model.addAttribute("list", result);
		model.addAttribute("keyword", keyword); // 검색어도 넘겨주기 (선택)
		model.addAttribute("search_count", result.size());
		return "products/product_list"; // 검색 결과 페이지로 이동
	}

	@RequestMapping("/search/sortproduct")
	public String getSortedSearchProducts(@RequestParam("sort") String sort, @RequestParam("keyword") String keyword,
			Model model) {
		List<ProductVO> list = products_dao.search_sort(sort, keyword);
		model.addAttribute("list", list);
		model.addAttribute("keyword", keyword);
		model.addAttribute("search_count", list.size());
		return "products/product_list_partial"; // 그대로 재사용
	}

	@RequestMapping("/category")
	public String categoryView(Model model, int category_id) {
		List<ProductVO> list = products_dao.getCategoryProducts(category_id);
		String category_name = category_dao.getCategoryName(category_id);

		model.addAttribute("list", list);
		model.addAttribute("category_name", category_name);
		model.addAttribute("category_id", category_id);
		model.addAttribute("search_count", list.size());

		return "products/category_list";
	}

	@RequestMapping("/category/sortproduct")
	public String getSortedProducts(@RequestParam("sort") String sort,
			@RequestParam(required = false) Integer category_id, Model model) {
		if (category_id == null) {
			return "products/category_list";
		}
		List<ProductVO> list = products_dao.category_sort(sort, category_id);
		model.addAttribute("list", list);
		model.addAttribute("category_id", category_id);
		return "products/product_list_partial"; // 전체 페이지 말고 리스트 조각만
	}

}
