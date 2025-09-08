package vo;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
    private int review_id;
    private int user_idx;
    private int product_id;

    private String order_id;
    private String masked_user_id;
    private String title;
    private String content;
    private String star_rating;
    private String admin_id;
    private String admin_reply;
    private String regdate;
    private String image1;
    private String is_visible;

    private MultipartFile imageFile;

    public int getReview_id() {
        return review_id;
    }

    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }

    public int getUser_idx() {
        return user_idx;
    }

    public void setUser_idx(int user_idx) {
        this.user_idx = user_idx;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getMasked_user_id() {
        return masked_user_id;
    }

    public void setMasked_user_id(String masked_user_id) {
        this.masked_user_id = masked_user_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStar_rating() {
        return star_rating;
    }

    public void setStar_rating(String star_rating) {
        this.star_rating = star_rating;
    }

    public String getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdmin_reply() {
        return admin_reply;
    }

    public void setAdmin_reply(String admin_reply) {
        this.admin_reply = admin_reply;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public String getImage1() {
        return image1;
    }

    public void setImage1(String image1) {
        this.image1 = image1;
    }

    public String getIs_visible() {
        return is_visible;
    }

    public void setIs_visible(String is_visible) {
        this.is_visible = is_visible;
    }

    public MultipartFile getImageFile() {
        return imageFile;
    }

    public void setImageFile(MultipartFile imageFile) {
        this.imageFile = imageFile;
    }
}
