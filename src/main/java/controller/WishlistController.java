package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.WishlistDAO;
import vo.UserVO;
import vo.WishlistVO;

@Controller
public class WishlistController 
{
    WishlistDAO wishlist_dao;

    public void setWishlist_dao(WishlistDAO wishlist_dao)
    {
        this.wishlist_dao = wishlist_dao;
    }
    
    //상품 디테일 들어올시 바로 실행되는 곳
    @RequestMapping("/user_wishList_status")
    @ResponseBody
    public Map<String, String> user_wishList_status(HttpSession session, int product_id) 
    {
    	System.out.println("1");
        Map<String, String> status = new HashMap<>();
        UserVO userVo = (UserVO) session.getAttribute("user");
        int user_idx = userVo.getUser_idx();
        int exists = wishlist_dao.user_wishList_selectOne(user_idx, product_id);
        if (exists == 1) {
            status.put("status", "added");
            System.out.println("a");
        } else {
            status.put("status", "removed");
            System.out.println("r");
        }
        return status;
    }
    
    
    // 상품 디테일 찜 버튼 
    @RequestMapping("/user_wishList")
    @ResponseBody
    public Map<String, String> user_wishList_toggle(HttpSession session, int product_id) {
        Map<String, String> status = new HashMap<>();
        UserVO userVo = (UserVO) session.getAttribute("user");
        int user_idx = userVo.getUser_idx();

        int exists = wishlist_dao.user_wishList_selectOne(user_idx, product_id);

        // 수정된 부분: '=' 대신 '==' 사용 및 로직 스왑
        if (exists == 1) { // 이미 찜 목록에 있으면 삭제
            int res2 = wishlist_dao.user_wishList_delete(user_idx, product_id);
            if (res2 == 1) 
            {
                status.put("status", "removed");
            } 
            else 
            {
                status.put("status", "error");
            }
        } 
        else 
        { // 찜 목록에 없으면 추가
            int res1 = wishlist_dao.user_wishList_insert(user_idx, product_id);
            if (res1 == 1) 
            {
                status.put("status", "added");
            } 
            else 
            {
                status.put("status", "error");
            }
        }
        return status;
    }
    
    @RequestMapping("/product_list_wishStatus")
    @ResponseBody
    public Map<String, List<Integer>> product_list_wishStatus
    		(@RequestBody Map<String,List<Integer>> map,
    		 HttpSession session)
    {
    	UserVO userVo = (UserVO)session.getAttribute("user");
    	int user_idx = userVo.getUser_idx();
    	List<Integer> proudct_id_List = wishlist_dao.user_wishList_selectAll(map.get("product_id"),user_idx);
    	
    	Map<String, List<Integer>> result_map = new HashMap<String, List<Integer>>();
    	result_map.put("product_id", proudct_id_List);
    	return result_map;
    }

    @RequestMapping("/wishlist")
    public String wishlist(HttpSession session, Model model) 
    {
       UserVO user = (UserVO) session.getAttribute("user");
       if(user == null) 
       {
          return "redirect:/login_form";   
       }
       
       // 사용자 찜목록 가져오기
       List<WishlistVO> wishList = wishlist_dao.selectWishList(user.getUser_idx());
       if(wishList == null) wishList = new ArrayList<>();

       // 모델에 전달
       model.addAttribute("wishList", wishList);

       return "users/wish_list";
    }
    
    @RequestMapping("/mypage/wishlist/delete")
    public String mypage_wishlist_delete(Model model,HttpSession session, int product_id,RedirectAttributes redirectAttributes)
    {
    	System.out.println("product_id : "+product_id);
    	UserVO vo = (UserVO)session.getAttribute("user");
    	int user_idx = vo.getUser_idx();
    	
    	wishlist_dao.mypage_wishlist_delete(user_idx, product_id);
    	redirectAttributes.addFlashAttribute("msg1", "찜 목록에서 삭제 완료");
    	return "redirect:/wishlist";
    }

}