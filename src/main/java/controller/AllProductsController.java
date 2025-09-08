package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.ProductsDAO;
import vo.AllProductsVO;


@Controller
public class AllProductsController           
{
	ProductsDAO product_dao;
	
	public void setProduct_dao(ProductsDAO product_dao) 
	{
		this.product_dao = product_dao;
	}
	
	@RequestMapping("/all/Products")
	public String all_products(Model model)
	{
		List<AllProductsVO> list = product_dao.AllProducts_list();
		
		model.addAttribute("list",list);
		model.addAttribute("search_count",list.size());
		return "products/all_products_list";
	}
	
	@RequestMapping("/all/sortProducts")
	public String getSortedAllProducts(@RequestParam("sort") String sort, Model model) {
		List<AllProductsVO> list = product_dao.AllProducts_sort(sort);
		model.addAttribute("list", list);
		return "products/product_list_partial";
	}
}
