package com.smt.webapp.util;

import java.util.Collections;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.hql.ast.QueryTranslatorImpl;
import org.hibernate.impl.SessionFactoryImpl;


/**
 * 传入hql语句,参数值列表,返回可执行的sql语句
 * @author xiufen.huang by 2014-07-03 
 */
public class HqlToSql {    
    
    /**
     * 处理结果信息,成功:为空,失败:错误信息
     */
    private static String resultMsg = "" ;
    private static final String nullMsg = "传入的hql为null或空!";
    
    /**
     * 获取处理结果信息,成功:为空,失败:错误信息
     * @return 处理结果信息
     */
    public static String getResultMsg() {
        return resultMsg;
    }    
    
    /**
     * 将hql语句转换为sql语句,无参数
     * @param hql 要转换的hql语句
     * @return 可执行的sql语句,当返回null,可以通过getResultMsg()方法查看处理结果信息
     */
    public static String transHqlToSql(Session session,String hql){
        // 当hql为null或空时,直接返回null
        if (hql == null || hql.equals("")) {
            resultMsg = nullMsg;
            return null;            
        }
        // 获取当前session
        // 得到session工厂实现类
        SessionFactoryImpl sfi = (SessionFactoryImpl)session.getSessionFactory();
        // 得到Query转换器实现类
        QueryTranslatorImpl queryTranslator = new QueryTranslatorImpl(hql, hql, Collections.EMPTY_MAP, sfi);
        queryTranslator.compile(Collections.EMPTY_MAP, false);  
        // 得到sql
        String sql = queryTranslator.getSQLString();
        // 关闭session
        return sql;  
    }
    
    /**
     * 将hql语句转换为sql语句,不需要格式化参数的情况
     * @param hql 要转换的hql语句
     * @param paramValues hql参数值列表,注意与参数的顺序一致
     * @return 可执行的sql语句,当返回null,可以通过getResultMsg()方法查看处理结果信息
     */
    public static String transHqlToSql(Session session,String hql,List paramValues){
        // 要返回的sql语句
        String sql = transHqlToSql(session,hql);
        // 当为null或空时,返回null
        if (sql == null || sql.equals("")) {
            resultMsg = nullMsg;
            return null;
        }
        
        // 赋参数值
        if (paramValues != null && paramValues.size() > 0) {            
            for (int i = 0; i < paramValues.size(); i++) {
                sql = sql.replaceFirst("\\?", "\\'"+paramValues.get(i).toString()+"\\'");
            }
        }
        return sql;
    }
    
    /**
     * 将hql语句转换为sql语句,有日期,Char等需要格式化参数的情况
     * @param hql 要转换的hql语句
     * @param paramValues hql参数值列表,注意与参数的顺序一致
     * @return 可执行的sql语句,当返回null,可以通过getResultMsg()方法查看处理结果信息
     */
    public static String formatHqlToSql(Session session,String hql,List paramValues){
        // 要返回的sql语句
        String sql = transHqlToSql(session,hql);
        // 当为null或空时,返回null
        if (sql == null || sql.equals("")) {
            resultMsg = nullMsg;
            return null;
        }
        
        // 赋参数值
        if (paramValues != null && paramValues.size() > 0) {
            for (int i = 0; i < paramValues.size(); i++) {
            	Object obj = paramValues.get(i);
            	String str = "";
            	if(obj instanceof Number){
            		str = ((Number)obj).toString();
            		sql = sql.replaceFirst("\\?", str);
            	}else{
            		str = (String)obj;
            		sql = sql.replaceFirst("\\?", "'"+str+"'");
            	}
            }
        }        
        return sql;
    }
    
}