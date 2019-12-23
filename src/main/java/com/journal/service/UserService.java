package com.journal.service;

import com.github.pagehelper.PageInfo;
import com.journal.bean.User;
import org.apache.ibatis.annotations.Param;

public interface UserService {
     User getUser(String username);
     PageInfo<User> getUserList(Integer pagenumber, Integer pagesize , @Param("username") String username);
     int addUser(User user);
     int delUser(String id);
     int cleanError(String id);
     int updatePwd(User user);
     int updateLoginInfo(int id,long times,long last_login_error_time,long last_login_time);
}
