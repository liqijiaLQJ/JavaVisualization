package com.lqj.dao;

import com.lqj.entity.Diagnose;
import com.lqj.entity.DiagnoseSum;
import com.lqj.util.SqlOperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 与数据库交互
public class CovidDao {
    // 获取确诊人数前十的省份
    public List<Diagnose> diagnose() {
        String sql = "SELECT * from covid  WHERE date='2020/3/18' ORDER BY province_diagnose DESC limit 10";
        List<Diagnose> list = new ArrayList<>();
        Connection conn = SqlOperation.getConn();
        PreparedStatement prep = null;
        ResultSet rs = null;

        try {
            prep = conn.prepareStatement(sql);
            rs = prep.executeQuery();
            while (rs.next()) {
                Diagnose diagnose = new Diagnose();
                diagnose.setId(rs.getInt(1));
                diagnose.setProvince(rs.getString(2));
                diagnose.setProvinceDiagnose(rs.getInt(3));
                diagnose.setProvinceCure(rs.getInt(4));
                diagnose.setProvinceDead(rs.getInt(5));
                diagnose.setDate(rs.getString(6));
                list.add(diagnose);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SqlOperation.close(rs,prep,conn);
        }

        return list;
    }


    // 获取每天确诊人数、治愈数、死亡数总计
    public List<DiagnoseSum> diagnoseSum() {
        String sql = "SELECT SUM(province_diagnose),SUM(province_cure),SUM(province_dead),date from covid GROUP BY date ORDER BY date";
        List<DiagnoseSum> list = new ArrayList<>();
        Connection conn = SqlOperation.getConn();
        PreparedStatement prep = null;
        ResultSet rs = null;

        try {
            prep = conn.prepareStatement(sql);
            rs = prep.executeQuery();
            while (rs.next()) {
                DiagnoseSum diagnoseSum = new DiagnoseSum();
                diagnoseSum.setDiagnoseSum(rs.getInt(1));
                diagnoseSum.setCureSum(rs.getInt(2));
                diagnoseSum.setDeadSum(rs.getInt(3));
                diagnoseSum.setDate(rs.getString(4));
                list.add(diagnoseSum);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SqlOperation.close(rs,prep,conn);
        }

        return list;
    }


    // 获取3月18日所有省份数据（缺少港澳台数据）
    // 为了匹配地图，这里需要将省份转换为简称
    public List<Diagnose> diagnoseAll() {
        String sql = "SELECT * FROM covid WHERE date='2020-03-18'";
        List<Diagnose> list = new ArrayList<>();
        Connection conn = SqlOperation.getConn();
        PreparedStatement prep = null;
        ResultSet rs = null;

        try {
            prep = conn.prepareStatement(sql);
            rs = prep.executeQuery();
            while (rs.next()) {
                Diagnose diagnose = new Diagnose();
                diagnose.setId(rs.getInt(1));

                // 替换省份为简称
                String province = rs.getString(2);
                if(province.equals("黑龙江省")|province.equals("内蒙古自治区")) {
                    diagnose.setProvince(province.substring(0,3));
                } else {
                    diagnose.setProvince(province.substring(0,2));
                }

                diagnose.setProvinceDiagnose(rs.getInt(3));
                diagnose.setProvinceCure(rs.getInt(4));
                diagnose.setProvinceDead(rs.getInt(5));
                diagnose.setDate(rs.getString(6));
                list.add(diagnose);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SqlOperation.close(rs,prep,conn);
        }

        return list;
    }


    // 获取湖北省疫情数据
    public List<Diagnose> diagnoseHubei() {
        String sql = "SELECT * FROM covid WHERE province='湖北省' ORDER BY date";
        List<Diagnose> list = new ArrayList<>();
        Connection conn = SqlOperation.getConn();
        PreparedStatement prep = null;
        ResultSet rs = null;

        try {
            prep = conn.prepareStatement(sql);
            rs = prep.executeQuery();
            while (rs.next()) {
                Diagnose diagnose = new Diagnose();
                diagnose.setId(rs.getInt(1));
                diagnose.setProvince(rs.getString(2));
                diagnose.setProvinceDiagnose(rs.getInt(3));
                diagnose.setProvinceCure(rs.getInt(4));
                diagnose.setProvinceDead(rs.getInt(5));
                diagnose.setDate(rs.getString(6));
                list.add(diagnose);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            SqlOperation.close(rs,prep,conn);
        }

        return list;
    }
}
