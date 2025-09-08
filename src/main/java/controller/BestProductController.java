package controller;

import java.util.List;
import java.util.stream.Collectors; // Collectors 임포트 추가

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.ProductsDAO;
import vo.BestProductVO;

@Controller
public class BestProductController 
{
	ProductsDAO product_dao;
	
	public void setProduct_dao(ProductsDAO product_dao) 
	{
		this.product_dao = product_dao;
	}
	
	@RequestMapping("/best_list")
	public String best_list(Model model)
	{
		List<BestProductVO> list = product_dao.bestList();
		model.addAttribute("search_count",list.size());
		model.addAttribute("list",list);
		
		// product_ids 추출하여 모델에 추가
		List<Integer> product_ids = list.stream()
								.map(BestProductVO::getProduct_id)
								.collect(Collectors.toList());
		model.addAttribute("product_ids", product_ids);
		
		return "products/best_products_list";
	}
	
	@RequestMapping("/best/sortProducts")
	public String getSortedBestProducts(@RequestParam("sort") String sort, 
										@RequestParam("product_ids") List<Integer> product_ids, // product_ids 파라미터 추가
										Model model) {
		List<BestProductVO> list = product_dao.bestProducts_sort(sort, product_ids); // product_ids 전달
		model.addAttribute("list", list);
		return "products/product_list_partial";
	}
}