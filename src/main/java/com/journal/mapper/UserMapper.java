package com.journal.mapper;

import com.journal.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User getUser(String name);
    List<User> getUserList(@Param("username") String username);
    int addUser(User user);
    int delUser(String id);
    int cleanError(String id);
    int updatePwd(User user);
    int updateLoginInfo(@Param("id") Integer id,@Param("last_login_error_times") long times,@Param("last_login_error_time")long last_login_error_time,@Param("last_login_time")long last_login_time);
}
