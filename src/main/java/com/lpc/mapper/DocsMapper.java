package com.lpc.mapper;

import com.lpc.pojo.Docs;
import org.apache.ibatis.annotations.*;

import java.util.List;


public interface DocsMapper {
    @Insert("INSERT INTO docs(title,type,url,author) values(#{title},#{type},#{url},#{author})")
    public int insertDocs(@Param("title") String title, @Param("type") String type, @Param("url") String url, @Param("author") String author);


    @Select("select * from docs where author=#{author}")
    public List<Docs> search(@Param("author") String author);

    @Select("select * from docs ")
    public List<Docs> showALlusers();

    @Delete("delete from docs where id=#{id}")
    public int delDocs(@Param("id") int id);

    @Update("UPDATE docs SET title=#{title}, type=#{type} WHERE id=#{id}")
    public void updateDoc(Docs doc);  // 更新数据库中的文档

    // 根据文档ID查询文档
    @Select("SELECT * FROM docs WHERE id = #{id}")
    Docs getDocById(int id);  // 根据文档ID从数据库查询文档
}
