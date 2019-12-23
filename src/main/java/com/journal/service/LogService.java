package com.journal.service;

import com.github.pagehelper.PageInfo;
import com.journal.bean.Log;

public interface LogService {
    PageInfo<Log> getPageLogs(Integer pageNumber, Integer pageSize,String userid,String keyword);
    int insertLog(Log log);
    int delLog(Integer id);
    Log toEditLog(String id);
    int updateLog(Log log);

}
