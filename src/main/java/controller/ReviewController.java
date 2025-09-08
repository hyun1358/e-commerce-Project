
package controller;

import java.io.File;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import dao.Order_detailDAO;
import dao.ReviewDAO;
import vo.OrderListVO;
import vo.ProductVO;
import vo.ReviewVO;
import vo.UserVO;

@Controller
public class ReviewController {

    ReviewDAO review_dao;
    Order_detailDAO detail_dao;

    public void setReview_dao(ReviewDAO review_dao) {
        this.review_dao = review_dao;
    }

    public void setDetail_dao(Order_detailDAO detail_dao) {
        this.detail_dao = detail_dao;
    }

    @RequestMapping("/review_write")
    public String reviewWrite(String returnUrl, Model model, ProductVO vo, String order_id) 
    {
        String modelUrl = "";
        if (returnUrl != null && !returnUrl.isEmpty()) {
            modelUrl = returnUrl;
        }
        model.addAttribute("vo", vo);
        model.addAttribute("order_id", order_id);
        model.addAttribute("returnUrl", modelUrl);
        return "users/review_write";
    }

    @RequestMapping("/review/regist")
    public String review_regist(MultipartFile imageFile, ReviewVO vo, HttpServletRequest request, HttpSession session) throws Exception 
    {
    	
        String newImagePath = uploadReviewImage(vo.getImageFile(), request);
        if (newImagePath != null) 
        {
            vo.setImage1(newImagePath);
        }

        UserVO user = (UserVO) session.getAttribute("user");
        vo.setUser_idx(user.getUser_idx());
        
        int res = review_dao.review_insert(vo);

        String returnUrl = request.getParameter("returnUrl");
        if (returnUrl != null && !returnUrl.isEmpty()) {
            return "redirect:" + returnUrl;
        }
        return "redirect:/orderhistory";
    }

    @RequestMapping("/review_show")
    public String review_view(String returnUrl, Model model, HttpSession session, ProductVO product, ReviewVO review) {
        UserVO user = (UserVO) session.getAttribute("user");
        review.setUser_idx(user.getUser_idx());
        
        ReviewVO res = review_dao.review_selectOne(review);
        
        model.addAttribute("productVO", product);
        model.addAttribute("reviewVO", res);
        model.addAttribute("returnUrl", returnUrl);
        
        return "users/review_show";
    }

    @RequestMapping("/review/modify")
    public String review_modify(ReviewVO vo, HttpServletRequest request, HttpSession session) throws Exception {
        if (vo.getOrder_id() == null || vo.getOrder_id().trim().isEmpty()) {
            return "redirect:/homepage";
        }

        String newImagePath = uploadReviewImage(vo.getImageFile(), request);
        if (newImagePath != null) {
            vo.setImage1(newImagePath);
        }

        UserVO user = (UserVO) session.getAttribute("user");
        vo.setUser_idx(user.getUser_idx());
        
        int res = review_dao.review_modify(vo);

        String returnUrl = request.getParameter("returnUrl");
        if (returnUrl != null && !returnUrl.isEmpty()) {
            return "redirect:" + returnUrl;
        }
        return "redirect:/orderhistory";
    }

    private String uploadReviewImage(MultipartFile imageFile, HttpServletRequest request) throws Exception {
        if (imageFile == null || imageFile.isEmpty()) {
            return null;
        }

        String uploadDir = "/resources/users/upload/review/";
        String realPath = request.getSession().getServletContext().getRealPath(uploadDir);
        File dir = new File(realPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String fileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
        File saveFile = new File(realPath, fileName);
        imageFile.transferTo(saveFile);

        return uploadDir + fileName;
    }
    
    /* review-list-empty */
    @RequestMapping("/reviewListEmpty")
    public String reviewListEmpty(HttpSession session, Model model) 
    {
    	UserVO user = (UserVO) session.getAttribute("user");
    	if(user == null) {
    		return "redirect:/login_form";
    	}
    	
    	List<String> orderIdList = detail_dao.selectReviewIdsByUser(user.getUser_idx());
    	Map<String, List<OrderListVO>> reviewList = new LinkedHashMap<>();

    	for (String order_id : orderIdList) {
    	    List<OrderListVO> products = detail_dao.selectDetailList(order_id);

    	    boolean hasUnwrittenReview = false;
    	    for (OrderListVO product : products) {
    	        if (product.getReview_id() == null) {
    	            hasUnwrittenReview = true;
    	            break;
    	        }
    	    }

    	    if (hasUnwrittenReview) {
    	        reviewList.put(order_id, products);
    	    }
    	}


    	model.addAttribute("reviewList", reviewList);

    	return "users/review-list-empty";
    }
    
    /* review-list-fill */
    @RequestMapping("/reviewListFill")
    public String reviewListFill(HttpSession session, Model model) 
    {
    	UserVO user = (UserVO) session.getAttribute("user");
    	if(user == null) {
    		return "redirect:/login_form";
    	}
    	
    	// ����� �ֹ� ��� ��������
    	List<String> orderIdList = detail_dao.selectReviewIdsByUser(user.getUser_idx());
    	Map<String, List<OrderListVO>> reviewList = new LinkedHashMap<>();

    	for (String order_id : orderIdList) {
    	    List<OrderListVO> products = detail_dao.selectDetailList(order_id);

    	    // �ֹ� ��ǰ ��ü �� �ϳ��� review_id�� null�̸� �߰�
    	    boolean hasUnwrittenReview = false;
    	    for (OrderListVO product : products) {
    	        if (product.getReview_id() != null) {
    	            hasUnwrittenReview = true;
    	            break;
    	        }
    	    }

    	    if (hasUnwrittenReview) {
    	        reviewList.put(order_id, products);
    	    }
    	}


    	// �𵨿� ����
    	model.addAttribute("reviewList", reviewList);

    	return "users/review-list-fill";
    }
    
}
