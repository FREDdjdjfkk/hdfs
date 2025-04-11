package com.lpc.mapper;

import com.lpc.pojo.Downlog;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface DownlogMapper {
    @Mapper
    @Insert("insert into downlog(title,author) values(#{title},#{author})")
    public int inserDownlog(@Param("title")String title,@Param("author") String author);


    @Select("select title,count(*) as num,author from downlog  where author =#{author} group by title")
    public List<Downlog> downStat(@Param("author") String author);

    @Select("SELECT * FROM downlog ORDER BY downdate DESC")
    List<Downlog> getAllDownlogs();

    @Delete("delete from downlog where author=#{author}")
    public int deleteByAuthor(@Param("author") String author);


}
