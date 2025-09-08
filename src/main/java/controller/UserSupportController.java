package controller;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import common.Paging;
import dao.InquiryDAO;
import dao.NoticeDAO;
import vo.InquiryVo;
import vo.NoticeVO;
import vo.UserVO;

@Controller
public class UserSupportController 
{
	NoticeDAO notice_dao;
	InquiryDAO inquiry_dao;
	
	public void setNotice_dao(NoticeDAO notice_dao) 
	{
		this.notice_dao = notice_dao;
	}
	
	public void setInquiry_dao(InquiryDAO inquiry_dao) 
	{
		this.inquiry_dao = inquiry_dao;
	}
	
	@RequestMapping("/goinquiry.do")
	public String inquiry(Integer user_idx,HttpSession session) 
	{
		if(user_idx == null)
		{
			return "redirect:/login_form";
		}
		return "support/inquiry";
	}
	
	@RequestMapping("/form_inquiry_insert")
	public String form_inquiry_insert( @RequestParam("type") String inquiryType,@ModelAttribute InquiryVo vo,
	    HttpServletRequest request, HttpSession session) throws Exception 
	{
		UserVO u_vo = (UserVO) session.getAttribute("user");
		if(u_vo == null)
		{
			return "redirct:/login";
		}
		vo.setUser_idx(u_vo.getUser_idx());
	    vo.setInquiryType(inquiryType);

	    for(MultipartFile f : vo.getImage())
	    {
	    	if(f == null || f.equals(""))
	    	{
	    		
	    	}
	    }
	    
	    List<MultipartFile> imageFiles = vo.getImage();
	    List<String> savedImagePaths = new ArrayList<>();

	    if (imageFiles != null && !imageFiles.isEmpty()) 
	    {
	        for (MultipartFile file : imageFiles) 
	        {
	            if (!file.isEmpty()) 
	            {
	                String imagePath = uploadInquiryImage(file, request);
	                savedImagePaths.add(imagePath);
	            }
	        }
	    }
	    else
	    {
	    	for (MultipartFile file : imageFiles) 
	        {
	            if (file.isEmpty() || file == null) 
	            {
	            	file=null;
	            }
	        }
	    }

	 if (!savedImagePaths.isEmpty()) {
	     for (int i = 0; i < savedImagePaths.size(); i++) {
	         try {
	             String methodName = "setImage" + (i + 1); // setImage1, setImage2, ...
	             Method method = InquiryVo.class.getMethod(methodName, String.class);
	             method.invoke(vo, savedImagePaths.get(i));
	         } catch (Exception e) {
	             e.printStackTrace(); // 占쏙옙占쏙옙 占쏙옙占�
	         }
	     }
	 }

	    System.out.println("Type: " + vo.getInquiryType());
	    System.out.println("Title: " + vo.getTitle());
	    System.out.println("Content: " + vo.getContent());
	    System.out.println("image1 : "+vo.getImage1());
	    System.out.println("image2 : "+vo.getImage2());
	    System.out.println("image3 : "+vo.getImage3());
	    System.out.println("image4 : "+vo.getImage4());
	    
	    int res = inquiry_dao.inquiry_insert(vo);

	    return "redirect:/my_inquiryList"; // 占쏙옙占� 占쏙옙 占쏙옙占� 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占싱뤄옙트
	}
	
	@RequestMapping("/my_inquiryList")
	public String myInquiryList(Model model,HttpSession session) 
	{
		UserVO u_vo = (UserVO) session.getAttribute("user");
		if(u_vo == null)
		{
			return "redirect:/login_form";
		}
		int user_idx = u_vo.getUser_idx();
		List<InquiryVo> list = inquiry_dao.inquiry_list(user_idx);
		model.addAttribute("inquiery_count",list.size());
		model.addAttribute("list",list);
		return "support/my_inquiries";
	}
	
	@RequestMapping("/support/section")
	public String goSupportSection() {
		return "support/customer_service";
	}
	
	@RequestMapping("/support/faq")
	public String goSupportFAQ() {
		return "support/faq";
	}
	
	//占쏙옙占쏙옙占쏙옙占쏙옙
	@RequestMapping("support/notice")
	public String notice(
			@RequestParam(defaultValue = "1") int page, 
			@RequestParam(defaultValue = "all") String sort,
			Model model) 
	{
		int blockList = 10;
		int blockPage = 5;
		
		int notice_cnt = notice_dao.notice_count();
		
		int startRow = (page-1) * blockList + 1;
		int endRow = startRow + blockList - 1;
		
		List<NoticeVO> list = notice_dao.notice_paging(startRow,endRow,sort);
		
		if(list == null)
		{
			list = new ArrayList<NoticeVO>();
		}
		
		String pageUrl = "notice";
		String searchParam = "sort=" + sort;
		String pagingHtml = Paging.getPaging(pageUrl, page, notice_cnt, searchParam, blockList, blockPage);
		model.addAttribute("list",list);
		model.addAttribute("pagingHtml",pagingHtml);
		
		return "support/notice";
	}
	
	private String uploadInquiryImage(MultipartFile imageFile, HttpServletRequest request) throws Exception {
        if (imageFile == null || imageFile.isEmpty()) {
            return null;
        }

        String uploadDir = "/resources/support/inquiry_image/";
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
	
}
