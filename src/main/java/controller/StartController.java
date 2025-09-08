package controller;

import java.util.List;
import java.util.Locale.Category;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.CategoryDAO;
import dao.ProductsDAO;
import vo.AllProductsVO;
import vo.BestProductVO;
import vo.CategoryVO;
import vo.ProductVO;

@Controller
public class StartController {

	ProductsDAO products_dao;
	CategoryDAO category_dao;

	public void setProducts_dao(ProductsDAO products_dao) {
		this.products_dao = products_dao;
	}

	public void setCategory_dao(CategoryDAO category_dao) {
		this.category_dao = category_dao;
	}

	@RequestMapping(value = { "/", "/homepage" })
	public String home(Model model, HttpServletRequest request) {
		List<BestProductVO> list = products_dao.bestList();
		AllProductsVO v1 = products_dao.main_select_one(10);
		AllProductsVO v2 = products_dao.main_select_one(4);

		model.addAttribute("model1", v1);
		model.addAttribute("model2", v2);
		model.addAttribute("best_list", list);

		ServletContext context = request.getSession().getServletContext();
		if (context.getAttribute("mainCategories") == null) {

			List<CategoryVO> allList = category_dao.getAllCategories();

			List<CategoryVO> parentList = allList.stream()
			    .filter(c -> c.getParent_category_id() == null)
			    .collect(Collectors.toList());

			Map<Integer, List<CategoryVO>> subCategoryMap = allList.stream()
			    .filter(c -> c.getParent_category_id() != null)
			    .collect(Collectors.groupingBy(CategoryVO::getParent_category_id));
			
			
			context.setAttribute("parentCategories", parentList);
			context.setAttribute("childCategoryMap", subCategoryMap);
		}

		return "homepage/main-page";
	}

}
