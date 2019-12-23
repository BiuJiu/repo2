package com.journal.bean;

public class User {
    private int id;
    private String name;
    private String password;
    private long add_time;
    private long last_login_time;
    private long last_login_error_times;
    private long last_login_error_time;
    private long usertype;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public long getAdd_time() {
        return add_time;
    }

    public void setAdd_time(long add_time) {
        this.add_time = add_time;
    }

    public long getLast_login_time() {
        return last_login_time;
    }

    public void setLast_login_time(long last_login_time) {
        this.last_login_time = last_login_time;
    }

    public long getLast_login_error_times() {
        return last_login_error_times;
    }

    public void setLast_login_error_times(long last_login_error_times) {
        this.last_login_error_times = last_login_error_times;
    }

    public long getLast_login_error_time() {
        return last_login_error_time;
    }

    public void setLast_login_error_time(long last_login_error_time) {
        this.last_login_error_time = last_login_error_time;
    }

    public long getUsertype() {
        return usertype;
    }

    public void setUsertype(long usertype) {
        this.usertype = usertype;
    }
}
