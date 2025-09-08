package controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;

import common.Paging;
import dao.AdminProductDAO;
import dao.CategoryDAO;
import vo.AdminProductVO;
import vo.CategoryVO;
import vo.ProductUploadVO;
import vo.SearchProductVO;

@Controller
public class AdminProductController {

	AdminProductDAO product_dao;
	CategoryDAO category_dao;

	public CategoryDAO getCategory_dao() {
		return category_dao;
	}

	public void setCategory_dao(CategoryDAO category_dao) {
		this.category_dao = category_dao;
	}

	public AdminProductDAO getProduct_dao() {
		return product_dao;
	}

	public void setProduct_dao(AdminProductDAO product_dao) {
		this.product_dao = product_dao;
	}

	@RequestMapping("/admin/product")
	public String admin_product(Model model, @RequestParam(defaultValue = "1") int page, HttpServletRequest request) {
		// List<AdminProductVO> list = product_dao.product_selectListAll();
		List<CategoryVO> category = category_dao.getParentCategoryAll();// �뜝�럡留믣뜝�럩留꾤뇖�궠�샑占쎈�ㅿ옙�뫁伊볩옙遊� �뤆�룊�삕�뜝�럩二ф뤆�룊�삕

		int blockList = 10;
		int blockPage = 5;

		int totalCount = product_dao.product_count();

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<AdminProductVO> list = product_dao.product_select_paging(startRow, endRow);
		if (list == null)
			list = new ArrayList<>();

		String pageUrl = request.getContextPath() + "/admin/product";
		String searchParam = "";
		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("parentCategories", category);
		model.addAttribute("product_list", list);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount", totalCount);

		return "admin_product/product_management";
	}

	@RequestMapping("/admin/product/edit")
	public String admin_productEdit(@RequestParam("product_id") String product_id, Model model) {

		if (product_id == null || product_id.isEmpty()) {
			return "redirect:/admin/product";
		}

		String[] strProductIds = product_id.split(",");
		int[] product_ids = new int[strProductIds.length];

		for (int i = 0; i < strProductIds.length; i++) {
			product_ids[i] = Integer.parseInt(strProductIds[i]);
		}

		List<ProductUploadVO> list = product_dao.getProductById(product_ids);
		List<CategoryVO> category = category_dao.getParentCategoryAll();// �뜝�럡留믣뜝�럩留꾤뇖�궠�샑占쎈�ㅿ옙�뫁伊볩옙遊� �뤆�룊�삕�뜝�럩二ф뤆�룊�삕

		model.addAttribute("products", list);
		model.addAttribute("parentCategories", category);

		return "admin_product/product_edit";
	}

	@PostMapping("/admin/product/update")
	@ResponseBody
	public Map<String, Object> updateProduct(HttpServletRequest request, ProductUploadVO vo,
			@RequestParam(value = "deletedIndexes", required = false) String deletedIndexesJson) {
		Map<String, Object> result = new HashMap<>();

		try {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Map<String, MultipartFile> fileMap = multiRequest.getFileMap();

			String[] paths = new String[] { "NO_CHANGE", "NO_CHANGE", "NO_CHANGE", "NO_CHANGE", "NO_CHANGE" };
			// �뜝�룞�삕�뜝�럩�궋�뜝�럩�뮔

			for (String key : fileMap.keySet()) {
				MultipartFile file = fileMap.get(key);
				if (file != null && !file.isEmpty()) {
					int index = extractIndexFromKey(key); // key�뜝�럥�뱺�뜝�럡�맋 �뜝�럩逾ε뜝�럥�몦�뜝�럥裕� 嶺뚮�⑹탪�뵳占�

					if (index >= 0 && index < paths.length) {
						String filePath = saveImageFile(file, request);
						paths[index] = filePath; // �뜝�럩逾ε뜝�럥�몦�뜝�럥裕욃뜝�럥�뱺 嶺뚮씮�돰�떋占� �뜝�룞�삕�뜝�럩�궋
					}
				}
			}

			// �뜝�럡�뀭�뜝�럩�젷�뜝�럥彛� �뜝�럩逾ε뜝�럥�몦�뜝�럥裕욃뜝�럥裕� 嶺뚮ㅏ援욑옙六삣뜝�럩�쓤�뜝�럩紐드슖�댙�삕 null�슖�댙�삕 �뜝�럡�맟�뜝�럩�젧
			// deletedIndexesJson �뜝�럥�냱�뜝�럥堉� �뛾�룊�삕 �뜝�럡�뀭�뜝�럩�젷 嶺뚳퐣瑗띰옙遊�
			if (deletedIndexesJson != null && !deletedIndexesJson.isEmpty()) {
				ObjectMapper mapper = new ObjectMapper();
				List<Integer> deletedIndexes = mapper.readValue(deletedIndexesJson, List.class);

				for (Integer idx : deletedIndexes) {
					int zeroBasedIdx = idx - 1; // 1-based -> 0-based �솻洹⑥삕�뜝�럩�꼶
					if (zeroBasedIdx >= 0 && zeroBasedIdx < paths.length) {

						if (paths[zeroBasedIdx].equals("NO_CHANGE")) {
							paths[zeroBasedIdx] = null; // �뜝�럡�뀭�뜝�럩�젷�뜝�럥彛� �뜝�럩逾졿쾬�꼶梨룟뜝占� �뇦猿뗫윥餓λ뜉�삕占쎈츎 null�슖�댙�삕 �뜝�럡�맟�뜝�럩�젧
						}
					}
				}
			}

			vo.setImagePaths(paths);

			int updatedRows = product_dao.updateProduct(vo);
			if (updatedRows > 0) {
				result.put("result", "success");
			} else {
				result.put("result", "no change");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "fail");
			result.put("message", e.getMessage());
		}

		return result;
	}

	// key�뜝�럥�뱺�뜝�럡�맋 �뜝�럩逾ε뜝�럥�몦�뜝�럥裕� 占쎈퉲�겫�슧�� (�뜝�럩援�: images[3] -> 3)
	private int extractIndexFromKey(String key) {
		try {
			int start = key.indexOf('[');
			int end = key.indexOf(']');
			if (start != -1 && end != -1 && end > start) {
				String numStr = key.substring(start + 1, end);
				return Integer.parseInt(numStr);
			}
		} catch (Exception e) {
			// 占쎈닱占쎈샍占쎈뻣
		}
		return -1;
	}

	private String saveImageFile(MultipartFile file, HttpServletRequest request) throws Exception {
		// �뜝�럥堉꾢뜝�럩�젷 �뜝�럥夷ⓨ뜝�럥�맠 �뇦猿뗫윥餓ο옙 (resources/products/image/upload)
		String uploadFolder = "/resources/products/image/upload/";
		String realPath = request.getSession().getServletContext().getRealPath(uploadFolder);

		File dir = new File(realPath);
		if (!dir.exists())
			dir.mkdirs();

		String originalFilename = file.getOriginalFilename();
		String fileName = originalFilename;
		File saveFile = new File(realPath, fileName);

		// �뤆�룇�듌�뜝占� �뜝�럩逾좑옙逾녑뜝占� �뜝�럥�냱�뜝�럩逾у뜝�럩逾� �댖怨뺣샍占쎌궨�뜝�럥由�嶺뚮〕�삕 �뜝�럥�뼪�뜝�럩�겱 占쎄껀占쎈듌�굢�띿삕�땻占� �솻洹⑥삕�뇦猿볦삕
		int count = 1;
		while (saveFile.exists()) {
			int dotIndex = fileName.lastIndexOf(".");
			String name = (dotIndex == -1) ? fileName : fileName.substring(0, dotIndex);
			String ext = (dotIndex == -1) ? "" : fileName.substring(dotIndex);
			fileName = name + "_" + count + ext;
			saveFile = new File(realPath, fileName);
			count++;
		}

		file.transferTo(saveFile);

		return "products/image/upload/" + fileName;
	}

	// �뜝�럥吏쀥뜝�럩�쓤�뜝�럩紐드슖�댙�삕 �뜝�럥由��뜝�럩留꾤뇖�궠�샑占쎈�ㅿ옙�뫁伊볩옙遊뷴뜝�럩紐� �뜝�럩�젧�솻洹ｏ옙�뜝�룞�삕 �뤆�룊�삕�뜝�럩二ф뤆�룊�삕
	@GetMapping("/categories/children")
	@ResponseBody
	public List<CategoryVO> getChildCategories(int parentId) {
		return category_dao.getChildrenByParentId(parentId);
	}

	@RequestMapping("/admin/product/regist_form")
	public String admin_productRegist(Model model) {
		List<CategoryVO> category = category_dao.getParentCategoryAll();// �뜝�럡留믣뜝�럩留꾤뇖�궠�샑占쎈�ㅿ옙�뫁伊볩옙遊� �뤆�룊�삕�뜝�럩二ф뤆�룊�삕

		model.addAttribute("parentCategories", category);
		return "admin_product/product_registration";
	}

	@PostMapping("/admin/product/register")
	@ResponseBody
	public Map<String, Object> insertProduct(HttpServletRequest request, ProductUploadVO vo) {
		Map<String, Object> result = new HashMap<>();

		try {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Map<String, MultipartFile> fileMap = multiRequest.getFileMap();

			String[] paths = new String[] { null, null, null, null, null }; // �뜝�럩逾졿쾬�꼶梨룟뜝占� �뇦猿뗫윥餓ο옙 �뜝�룞�삕�뜝�럩�궋�뜝�럩�뮔

			for (String key : fileMap.keySet()) {
				MultipartFile file = fileMap.get(key);
				if (file != null && !file.isEmpty()) {
					int index = extractIndexFromKey(key); // key�뜝�럥�뱺�뜝�럡�맋 �뜝�럩逾ε뜝�럥�몦�뜝�럥裕� 占쎈퉲�겫�슧��
					if (index >= 0 && index < paths.length) {
						String filePath = saveImageFile(file, request);
						paths[index] = filePath;
					}
				}
			}

			vo.setImagePaths(paths);

			int insertedRows = product_dao.insertProduct(vo);
			if (insertedRows > 0) {
				result.put("result", "success");
			} else {
				result.put("result", "fail");
				result.put("message", "상품 찾을수 없음");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "fail");
			result.put("message", e.getMessage());
		}

		return result;
	}

	@RequestMapping("/admin/product/search") // �뜝�럩援℡뜝�럥裕� @GetMapping
	public String searchProducts(@ModelAttribute SearchProductVO search, // VO�뿉 �뙆�씪誘명꽣 �옄�룞 諛붿씤�뵫
			Model model, @RequestParam(defaultValue = "1") int page, HttpServletRequest request) {
		// List<AdminProductVO> products = product_dao.searchProducts(search);

		int blockList = 10;
		int blockPage = 5;

		int totalCount = product_dao.countSearchResults(search);

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<AdminProductVO> products = product_dao.searchProductsPaging(search, startRow, endRow);

		if (products == null)
			products = new ArrayList<>();

		String pageUrl = request.getContextPath() + "/admin/product/search";
		String searchParam = search.toQueryString();
		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("product_list", products);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount", totalCount);

		// ajax �슂泥� �뙋�떒 (header �삉�뒗 parameter 泥댄겕)
		String requestedWith = request.getHeader("X-Requested-With");
		if ("XMLHttpRequest".equals(requestedWith)) {
			// ajax �슂泥�: 遺�遺� jsp 諛섑솚
			return "admin_product/adminproduct_list_partial";
		} else {
			// �씪諛� �슂泥�: �쟾泥� jsp 諛섑솚
			return "admin_product/product_management";
		}
	}

	@PostMapping("/admin/product/delete")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> deleteProduct(@RequestBody Map<String, List<Integer>> param) {
		Map<String, Object> result = new HashMap<>();
		try {
			List<Integer> productIds = param.get("productIds");

			// 1. 由щ럭 �궘�젣
			product_dao.deleteReview(productIds);

			// 2. 二쇰Ц �긽�꽭 �궘�젣
			product_dao.deleteOrderDetail(productIds);

			// 3. �옣諛붽뎄�땲 �궘�젣
			product_dao.deleteCart(productIds);

			// 4. 利먭꺼李얘린 �궘�젣
			product_dao.deleteFavorite(productIds);

			// 5. 臾몄쓽湲� �궘�젣
			product_dao.deleteInquiry(productIds);

			// 6. �끂�듃遺� �궗�뼇 �궘�젣
			//product_dao.deleteLaptopSpec(productIds);
			
			//6.approval_pending 추가
			product_dao.deleteApprovalPending(productIds);

			// 7. �젣�뭹 �궘�젣
			int res = product_dao.deleteProducts(productIds);

			if (res == productIds.size()) {
				result.put("success", true);
			} else {
				result.put("success", false);
				result.put("message", "�궘�젣�뿉 �떎�뙣�뻽�뒿�땲�떎.");

			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result.put("success", false);
			result.put("error", e.getMessage());
			throw e; // rollback을 유도
		}
		return result;
	}

}
