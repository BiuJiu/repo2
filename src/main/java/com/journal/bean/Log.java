package com.journal.bean;

public class Log {
    private int id;
    private int userid;
    private String title;
    private String thumbimg;
    private String content;
    private String category;
    private User user;
    private String keyword;
    private long add_time;

    public Log(Integer id, Integer userid, String title, String thumbimg, String content,String category) {
        super();
        this.id = id;
        this.userid = userid;
        this.title = title;
        this.thumbimg = thumbimg;
        this.content = content;
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Log() {
        super();
    }
    public void setUser(User user){this.user=user;}
    public User getUser(){return  user;}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbimg() {
        return thumbimg;
    }

    public void setThumbimg(String thumbimg) {
        this.thumbimg = thumbimg;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getAdd_time() {
        return add_time;
    }

    public void setAdd_time(long add_time) {
        this.add_time = add_time;
    }
}
