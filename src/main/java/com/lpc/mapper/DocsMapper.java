package com.lpc.mapper;

import com.lpc.pojo.Docs;
import org.apache.ibatis.annotations.*;

import java.util.List;


public interface DocsMapper {
    @Insert("INSERT INTO docs(title,type,parentPath,url,author,isFolder) " +
            "VALUES(#{title}, #{type}, #{parentPath}, #{url}, #{author}, #{isFolder})")
    int insertDocsExtended(@Param("title") String title,
                           @Param("type") String type,
                           @Param("parentPath") String parentPath,
                           @Param("url") String url,
                           @Param("author") String author,
                           @Param("isFolder") boolean isFolder);

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

    //按路径查询内容
    @Select("SELECT * FROM docs WHERE author=#{author} AND parentPath=#{parentPath}")
    List<Docs> searchByParent(@Param("author") String author, @Param("parentPath") String parentPath);
    //修改文件夹名字
    @Update("UPDATE docs SET title=#{newTitle} WHERE id=#{id}")
    int updateTitle(@Param("id") int id, @Param("newTitle") String newTitle);
    @Select("SELECT * FROM docs WHERE id=#{id}")
    Docs findById(@Param("id") int id);

    @Update("UPDATE docs SET title=#{newTitle}, url=#{newUrl} WHERE id=#{id}")
    int updateFolderInfo(@Param("id") int id, @Param("newTitle") String newTitle, @Param("newUrl") String newUrl);

    /**
     * 批量更新子文档路径信息
     */
    @Update("UPDATE docs " +
            "SET url = REPLACE(url, #{oldPrefix}, #{newPrefix}), " +
            "    parentPath = REPLACE(parentPath, #{oldPrefix}, #{newPrefix}) " +
            "WHERE url LIKE CONCAT(#{oldPrefix}, '%') AND id != #{id}")
    int updateChildrenPath(@Param("oldPrefix") String oldPrefix,
                           @Param("newPrefix") String newPrefix);

    @Select("SELECT DISTINCT url FROM docs WHERE author = #{author} AND isFolder = true")
    List<String> findAllFolderUrls(@Param("author") String author);
}
