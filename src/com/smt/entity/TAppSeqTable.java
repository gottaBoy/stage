package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * TAppUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="t_app_seq_table"
    ,catalog="no1stage"
)

public class TAppSeqTable  implements java.io.Serializable {
 
	private static final long serialVersionUID = 784214956986648018L;
	private Integer id;
    private String sequenceId;
    private String tableName;
       

	/** default constructor */
    public TAppSeqTable() {
    }
 
   
    // Property accessors
    @Id @GeneratedValue
    
    @Column(name="ID", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name="sequence_id")
    	public String getSequenceId() {
		return sequenceId;
	}

	public void setSequenceId(String sequenceId) {
		this.sequenceId = sequenceId;
	}

	@Column(name="table_name", length=60)
 	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}


}