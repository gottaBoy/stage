package com.smt.webapp.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class BaseDao extends HibernateDaoSupport{
	 //注入数据源
	 @Resource(name="sessionFactory")
	 public void setSF(SessionFactory sessionFactory) { 
		 super.setSessionFactory(sessionFactory); 
	 }
	 
	 private static final Log log = LogFactory.getLog(BaseDao.class);
		public void save(Object obj){
			log.debug("save  instance");
			try {
				getHibernateTemplate().save(obj);
				log.debug("save successful");
			} catch (RuntimeException re) {
				log.error("save failed", re);
				throw re;
			}
		}

		
		public void update(Object obj){
			log.debug("update  instance");
			try {
				getHibernateTemplate().update(obj);
				log.debug("save successful");
			} catch (RuntimeException re) {
				log.error("save failed", re);
				throw re;
			}
		}

		public void saveOrUpdate(Object obj){
			log.debug("update  instance");
			try{
				getHibernateTemplate().saveOrUpdate(obj);
				log.debug("save successful");
			} catch (RuntimeException re) {
				log.error("save failed", re);
				throw re;
			}
		}

		public void evict(Object obj) {
			log.debug("evict  instance");
			try {
				getHibernateTemplate().evict(obj);
				log.debug("evict successful");
			} catch (RuntimeException re) {
				log.error("evict failed", re);
				throw re;
			}
		}

		public void delete(Object obj) {
			log.debug("deleting  instance");
			try {
				getHibernateTemplate().delete(obj);
				log.debug("delete successful");
			} catch (RuntimeException re) {
				log.error("delete failed", re);
				throw re;
			}
		}

		public Object merge(Object obj) {
			log.debug("merging  instance");
			try {
				Object result = getHibernateTemplate().merge(obj);
				log.debug("merge successful");
				return result;
			} catch (RuntimeException re) {
				log.error("merge failed", re);
				throw re;
			}
		}

		@Override
		protected void initDao() {
		}

		public List findByExample(final Object instance) {
			return (List) getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session) {
					String className = instance.getClass().getName();

					BaseDao.log.debug("finding " + className
							+ " instance by example");
					try {
						List results = session.createCriteria(className).add(
								Example.create(instance)).list();

						BaseDao.log
								.debug("find by example successful, result size: "
										+ results.size());
						return results;
					} catch (RuntimeException re) {
						BaseDao.log.error("find by example failed", re);
						throw re;
					}
				}
			});
		}

		public List executeQuery(String hql) {
			return executeQuery(hql, null);
		}

		public List executeQuery(String hql, Object[] values) {
			log.debug("executeQuery hql by " + hql);
			try {
				List list = getHibernateTemplate().find(hql, values);

				return list;
			} catch (RuntimeException re) {
				log.error("executeQuery hql failed by " + hql, re);
				throw re;
			}
		}

		public List executeQuery(final String hql, final Object[] values,
				final int begin, final int rowCount) {
			return (List) getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException {
					Query query = session.createQuery(hql);
					if (values != null) {
						for (int i = 0; i < values.length; i++) {
							query.setParameter(i, values[i]);
						}
					}
					query.setFirstResult(begin);
					query.setMaxResults(rowCount);
					List results = query.list();

					return results;
				}
			});
		}
		public List executeQuery1(final String hql, final Object[] values,
				final int begin, final int rowCount) {
			return (List) getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException {
					Query query = session.createSQLQuery(hql);
					if (values != null) {
						for (int i = 0; i < values.length; i++) {
							query.setParameter(i, values[i]);
						}
					}
					query.setFirstResult(begin);
					query.setMaxResults(rowCount);
					List results = query.list();

					return results;
				}
			});
		}
		
		public List executeQuery2(final String hql, final Object[] values,
				final int begin, final int rowCount) {
			return (List) getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session)
						throws HibernateException {
					Query query = session.createQuery(hql);
					if (values != null) {
						for (int i = 0; i < values.length; i++) {
							if(i==0||i==1||i==2){
								query.setParameter(i, "演员",Hibernate.STRING);
							}else{
								query.setParameter(i, values[i]);
							}
						}
					}
					query.setFirstResult(begin);
					query.setMaxResults(rowCount);
					List results = query.list();

					return results;
				}
			});
		}

		public List executeQuery(String hql, int begin, int rowCount) {
			return executeQuery(hql, null, begin, rowCount);
		}

		public Integer getRowCount(String hql) {
			return getRowCount(hql, null);
		}

		public Double getSum(final String hql, final Object[] values, final String name) {
			return (Double) getHibernateTemplate().execute(
					new HibernateCallback() {
						public Object doInHibernate(Session session)
								throws HibernateException {
							String counthql = hql.substring(hql.toLowerCase()
									.indexOf("from"));
							counthql = "select sum("+name+") " + counthql;
							Query query = session.createQuery(counthql);
							if (values != null) {
								for (int i = 0; i < values.length; i++) {
									query.setParameter(i, values[i]);
								}
							}
							
							Double totalCount = 0.0;
							if(query.list().size() > 0) {
								Object obj = query.list().get(0);
								if(obj != null) {
									totalCount = new Double(obj.toString());
								}
							}
							
							return totalCount;
						}
					});
		}
		
		public Integer getRowCount(final String hql, final Object[] values) {
			return (Integer) getHibernateTemplate().execute(
					new HibernateCallback() {
						public Object doInHibernate(Session session)
								throws HibernateException {
							String counthql = hql.substring(hql.toLowerCase()
									.indexOf("from"));
							counthql = "select count(*) " + counthql;
							Query query = session.createQuery(counthql);
							if (values != null) {
								for (int i = 0; i < values.length; i++) {
									query.setParameter(i, values[i]);
								}
							}
							
							Integer totalCount = 0;
							if(query.list().size() > 0) {
								Object obj = query.list().get(0);
								totalCount = new Integer(obj.toString());
							}
							
							return totalCount;
						}
					});
		}
		public Integer getRowCount1(final String hql, final Object[] values) {
			return (Integer) getHibernateTemplate().execute(
					new HibernateCallback() {
						public Object doInHibernate(Session session)
								throws HibernateException {
							//String counthql = hql.substring(hql.toLowerCase()
									//.indexOf("from"));
							//counthql = "select count(*) " + counthql;
							Query query = session.createQuery(hql);
							if (values != null) {
								for (int i = 0; i < values.length; i++) {
									query.setParameter(i, values[i]);
								}
							}
							Object obj = query.list().get(0);
							Integer totalCount = new Integer(obj.toString());
							return totalCount;
						}
					});
		}

		public int update(String hql) {
			return getHibernateTemplate().bulkUpdate(hql);
		}

		public void executeUpdate(String hql) {
			getHibernateTemplate().bulkUpdate(hql);
		}

		public void flush() {
			getHibernateTemplate().flush();
		}

		public int executeUpdate(String hql, Object[] values) {
			return getHibernateTemplate().bulkUpdate(hql, values);
		}

		public Object load(Class entityClass, Serializable id) {
			Object object = getHibernateTemplate().get(entityClass, id);
			return object;
		}

		public Session getHibernateSession() {
			return getSession();
		}
	 	 
}
