package com.lpc.service;


import org.apache.commons.compress.utils.IOUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.springframework.stereotype.Service;

import java.io.InputStream;

@Service
public class HDFSService {
    static Configuration conf;
    static FileSystem fs;
    static {
        try{
            conf=new Configuration();
            conf.set("fs.defaultFS","hdfs://master:9000");
            System.setProperty("HADOOP_USER_NAME","hadoop");
            fs= FileSystem.get(conf);
    }catch(Exception e){
            System.out.println("连接HDFS文件系统发生异常："+e.toString());
        }
    }

    /**
     * 在HDFS文件系统中创建目录
     * @param dir
     */
    public void createDir(String dir){
        try {
            fs.mkdirs(new Path("/"+dir+"/"));
        }catch(Exception e){
            System.out.println("在HDFS文件系统中创建目录时发生异常");
        }

    }

    public void upload(String filename,InputStream in) {
        FSDataOutputStream out;
        try {
            out=fs.create(new Path(filename));
            IOUtils.copy(in,out);
            out.close();
        }catch (Exception e){
            System.out.println("上传文档时发生异常"+e.toString());
        }
    }

    /**
     * 下载
     * @param filepath
     * @return
     */
    public InputStream down(String filepath){
        FSDataInputStream in=null;
        try {
            in=fs.open(new Path(filepath));
        }catch (Exception e){
            System.out.println("在HDFS文件中下载记录时发生异常："+e.toString());
        }
        return in;
    }

    /**
     * 删除
     * @param filePath
     */
    public void delFile(String filePath) {
        try {
            Path path = new Path(filePath);
            if (fs.exists(path)) {
                boolean success = fs.delete(path, true);  // true 表示递归删除（目录也删）
                if (!success) {
                    System.out.println("HDFS 删除失败：" + filePath);
                } else {
                    System.out.println("✅ HDFS 删除成功：" + filePath);
                }
            } else {
                System.out.println("⚠️ HDFS 不存在该路径：" + filePath);
            }
        } catch (Exception e) {
            System.out.println("HDFS 删除异常：" + e.getMessage());
        }
    }

    /**
     * 重命名文件夹
     * @param oldPath
     * @param newPath
     */
    public void renameDir(String oldPath, String newPath) {
        try {
            Path oldP = new Path(oldPath);
            Path newP = new Path(newPath);
            fs.rename(oldP, newP);
        } catch (Exception e) {
            System.out.println("HDFS 重命名文件夹失败: " + e.getMessage());
        }
    }
}
