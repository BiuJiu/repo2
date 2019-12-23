package com.journal.mapper;
import com.journal.bean.Log;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface LogMapper {
     List<Log> selectLogs(@Param("userid") String userid, @Param("title") String title);
     int insertLog(Log log);
     int delLog(Integer id);
     Log toEditLog(@Param("id") String id);
     int updateLog(Log log);
}
