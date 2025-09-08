package controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UserDAO;
import vo.UserVO;

@Controller
public class EmailVerificationController {

    private JavaMailSender mailSender;
    private UserDAO user_dao;

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void setUser_dao(UserDAO user_dao) {
        this.user_dao = user_dao;
    }

    @RequestMapping("/email_ver")
    @ResponseBody
    public String email_verification(String email) {
        if(mailSender == null) {
            System.out.println("mailSender is null!!!");
        }

        Random random = new Random();
        int auth_code = random.nextInt(888888) + 111111;

        String setFrom = "chs010604@naver.com";
        String toMail = email;
        String title = "(Good Luck) 회원가입 인증번호";
        String content = ""
                + "<div style=\"max-width:600px;margin:0 auto;padding:30px;border:1px solid #ddd;border-radius:10px;"
                + "font-family:'Apple SD Gothic Neo','Malgun Gothic','Arial',sans-serif;background-color:#f9f9f9;\">"
                + "<h2 style=\"text-align:center;color:#2c3e50;margin-bottom:30px;\">회원 인증 코드</h2>"
                + "<p style=\"font-size:16px;color:#333;line-height:1.6;margin-bottom:20px;\">안녕하세요.<br>"
                + "아래 인증번호를 입력해주세요.</p>"
                + "<div style=\"text-align:center;margin:30px 0;\">"
                + "<span style=\"display:inline-block;background-color:#2c3e50;color:#fff;padding:15px 30px;"
                + "font-size:24px;letter-spacing:3px;border-radius:8px;\">" + auth_code + "</span>"
                + "</div>"
                + "<p style=\"font-size:14px;color:#777;text-align:center;\">해당 인증번호는 5분간 유효합니다.</p>"
                + "</div>";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return String.format("{\"auth_code\":\"%s\"}", auth_code);
    }

    @RequestMapping("/id_find")
    public String user_id_find(String email) {
        System.out.println("email : " + email); 

        UserVO vo = user_dao.find(email);
        String id = "";

        if(vo == null) {
            id = "아이디가 존재하지 않습니다.";
        } else if(vo.getSocial().equals("local")) {
            id = vo.getUser_id();
        } else if(vo.getSocial().equals("naver")) {
            id = "네이버 소셜 로그인 회원입니다.";
        } else if(vo.getSocial().equals("kakao")) {
            id = "카카오 소셜 로그인 회원입니다.";
        } else if(vo.getSocial().equals("google")) {
            id = "구글 소셜 로그인 회원입니다.";
        }

        String setFrom = "chs010604@naver.com";
        String toMail = email;
        String title = "(Good Luck) 아이디 찾기";
        String content = ""
                + "<div style=\"max-width:600px;margin:0 auto;padding:30px;border:1px solid #ddd;border-radius:10px;"
                + "font-family:'Apple SD Gothic Neo','Malgun Gothic','Arial',sans-serif;background-color:#f9f9f9;\">"
                + "<h2 style=\"text-align:center;color:#2c3e50;margin-bottom:30px;\">아이디 찾기 결과</h2>"
                + "<p style=\"font-size:16px;color:#333;line-height:1.6;margin-bottom:20px;\">안녕하세요.<br>"
                + "요청하신 아이디 정보입니다.</p>"
                + "<div style=\"text-align:center;margin:30px 0;\">"
                + "<span style=\"display:inline-block;background-color:#2c3e50;color:#fff;padding:15px 30px;"
                + "font-size:24px;letter-spacing:3px;border-radius:8px;\">" + id + "</span>"
                + "</div>"
                + "<p style=\"font-size:14px;color:#777;text-align:center;\">해당 아이디 정보는 안전하게 보관해주세요.</p>"
                + "</div>";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return "redirect:id_find_form?check=yes";
    }

    // 비밀번호 초기화
    Random random = new Random();
    int num = random.nextInt(999999) + 1;

    @RequestMapping("/pwd_find")
    public String user_pwd_find(String email) {
        System.out.println("pwd_find email : " + email); 

        UserVO vo = user_dao.find(email);
        String pwd = "";

        if(vo.getSocial().equals("local")) {
            Map<String, String> map = new HashMap<>();
            map.put("email", email);
            map.put("user_pwd", String.valueOf(num));
            int res = user_dao.pwd_reset(map);
            if(res == 1) {
                System.out.println("비밀번호 초기화 성공");
            }
            pwd = vo.getUser_pwd();
        } else if(vo.getSocial().equals("naver")) {
            pwd = "네이버 소셜 로그인 회원입니다.";
        } else if(vo.getSocial().equals("kakao")) {
            pwd = "카카오 소셜 로그인 회원입니다.";
        }

        String setFrom = "chs010604@naver.com";
        String toMail = email;
        String title = "(Good Luck) 비밀번호 초기화 안내";
        String content = ""
                + "<div style=\"max-width:600px;margin:0 auto;padding:30px;border:1px solid #ddd;border-radius:10px;"
                + "font-family:'Apple SD Gothic Neo','Malgun Gothic','Arial',sans-serif;background-color:#f9f9f9;\">"
                + "<h2 style=\"text-align:center;color:#2c3e50;margin-bottom:30px;\">비밀번호 초기화 안내</h2>"
                + "<p style=\"font-size:16px;color:#333;line-height:1.6;margin-bottom:20px;\">안녕하세요.<br>"
                + "요청하신 임시 비밀번호입니다.</p>"
                + "<div style=\"text-align:center;margin:30px 0;\">"
                + "<span style=\"display:inline-block;background-color:#2c3e50;color:#fff;padding:15px 30px;"
                + "font-size:24px;letter-spacing:3px;border-radius:8px;\">" + num + "</span>"
                + "</div>"
                + "<p style=\"font-size:14px;color:#777;text-align:center;\">해당 임시 비밀번호로 로그인 후 반드시 변경해주세요.</p>"
                + "</div>";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch(Exception e) {
            e.printStackTrace();
        }

        return "redirect:id_find_form?check=yes";
    }
}
