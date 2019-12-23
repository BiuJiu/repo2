package com.journal.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.journal.bean.User;
import com.journal.mapper.UserMapper;
import com.journal.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public User getUser(String name){
        User user = userMapper.getUser(name);

        return user;
    }

    @Override
    public PageInfo<User> getUserList(Integer pageNumber, Integer pageSize, String username) {
        PageHelper.startPage(pageNumber,pageSize);
        List<User> users = userMapper.getUserList(username);
        // 5表示设置连续显示的页号数目 1 2 3 4 5
        return new PageInfo<>(users,5);
    }

    @Override
    public int addUser(User user) {
        int res = userMapper.addUser(user);
        return res;
    }

    @Override
    public int delUser(String id) {
        int res = userMapper.delUser(id);
        return res;
    }
    @Override
    public int updatePwd(User user) {
        int res = userMapper.updatePwd(user);
        return res;
    }
    @Override
    public int cleanError(String id) {
        int res = userMapper.cleanError(id);
        return res;
    }
    @Override
    public int updateLoginInfo(int id,long times,long last_login_error_time,long last_login_time) {
        int res = userMapper.updateLoginInfo(id,times,last_login_error_time,last_login_time);
        return res;
    }
}
