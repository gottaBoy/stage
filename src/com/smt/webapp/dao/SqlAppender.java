package com.smt.webapp.dao;

import java.util.ArrayList;
import java.util.List;

public class SqlAppender
{
  private StringBuffer psSql;
  private List paramValues;

  public SqlAppender(String hql)
  {
    this.psSql = new StringBuffer(hql);
    this.paramValues = new ArrayList();
  }

  public SqlAppender(SqlAppender sqlAppender)
  {
    this.psSql = new StringBuffer(sqlAppender.psSql.toString());
    this.paramValues = new ArrayList(sqlAppender.paramValues);
  }

  public SqlAppender append(String cond, Object paraValue)
  {
    this.psSql.append(cond);
    this.paramValues.add(paraValue);
    return this;
  }

  public SqlAppender append(String cond) {
    this.psSql.append(cond);
    return this;
  }

  public SqlAppender append(String cond, char paraValue)
  {
    return append(cond, new Character(paraValue));
  }

  public SqlAppender append(String cond, int paraValue) {
    return append(cond, new Integer(paraValue));
  }

  public SqlAppender append(String cond, long paraValue) {
    return append(cond, new Long(paraValue));
  }

  public SqlAppender append(String cond, float paraValue) {
    return append(cond, new Float(paraValue));
  }

  public SqlAppender append(String cond, double paraValue) {
    return append(cond, new Double(paraValue));
  }

  public String getPsSql() {
    return this.psSql.toString();
  }

  public Object[] getParamsValues() {
    return this.paramValues.toArray();
  }

  public void setPsSql(String sql)
  {
    this.psSql = new StringBuffer(sql);
  }
}
