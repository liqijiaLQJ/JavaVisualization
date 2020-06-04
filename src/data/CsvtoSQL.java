package data;

import com.lqj.entity.Diagnose;
import com.lqj.util.SqlOperation;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 将csv文件内容存入数据库中
public class CsvtoSQL {
    // 读取csv内容
    public static List<Diagnose> readCSV(String filename) {
        List<Diagnose> diagnoseList =new ArrayList<>();
        try {
            BufferedReader reader = new BufferedReader(new FileReader("d://"+filename));// 文件名
            reader.readLine();//第一行信息，为标题信息，不用
            String line = null;
            while ((line = reader.readLine()) != null) {
                Diagnose diagnose = new Diagnose();
                String item[] = line.split(",");// CSV格式文件为逗号分隔符文件，这里根据逗号切分
                diagnose.setProvince(item[0]);
                diagnose.setProvinceDiagnose(Integer.parseInt(item[1]));
                diagnose.setProvinceCure(Integer.parseInt(item[2]));
                diagnose.setProvinceDead(Integer.parseInt(item[3]));
                diagnose.setDate(item[4]);

                diagnoseList.add(diagnose);
            }
                System.out.println("从CSV中读取到的数据：" + diagnoseList.get(1).getDate());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return diagnoseList;
    }

    // 存储到mysql数据库中
    public static void toSql(List<Diagnose> list) {
        Connection conn = SqlOperation.getConn();
        String sql = "INSERT INTO covid(province,province_diagnose,province_cure,province_dead,date) VALUES(?,?,?,?,?)";
        PreparedStatement prep = null;

        try {
            // 不让它自动提交
            conn.setAutoCommit(false);
            prep = conn.prepareStatement(sql);
            int num=0;
            for (Diagnose value : list) {
                num++;
                prep.setString(1, value.getProvince());
                prep.setInt(2,value.getProvinceDiagnose());
                prep.setInt(3,value.getProvinceCure());
                prep.setInt(4,value.getProvinceDead());
                prep.setString(5,value.getDate());
                prep.addBatch();
                if(num>500){
                    System.out.println(prep);
                    // 批量更新
                    prep.executeBatch();
                    conn.commit();
                    num=0;
                }
                System.out.println(prep);
                prep.executeBatch();
                conn.commit();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SqlOperation.close(prep,conn);
        }
    }

    public static void main(String[] args) {
        List<Diagnose> diagnoseList = readCSV("COVID19.csv");
        toSql(diagnoseList);
    }
}
