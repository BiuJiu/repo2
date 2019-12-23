package com.journal.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.journal.bean.Log;
import com.journal.mapper.LogMapper;
import com.journal.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class LogServiceImpl implements LogService {
    @Autowired
    private LogMapper logMapper ;
    @Override
    public PageInfo<Log> getPageLogs(Integer pageNumber, Integer pageSize,String userid,String keyword) {
        PageHelper.startPage(pageNumber,pageSize);
        List<Log> logs = logMapper.selectLogs(userid, keyword);
        // 5表示设置连续显示的页号数目 1 2 3 4 5
        return new PageInfo<>(logs,5);
    }

    @Override
    public int insertLog(Log log) {
        int res = logMapper.insertLog(log);
        return res;
    }

    @Override
    public int delLog(Integer id) {
        int res = logMapper.delLog(id);
        return res;
    }

    @Override
    public Log toEditLog(String id) {
        Log res = logMapper.toEditLog(id);
        return res;
    }

    @Override
    public int updateLog(Log log) {
        int res = logMapper.updateLog(log);
        return res;
    }
}
