package com.framework.spring.sample.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.framework.spring.common.support.CommonConfig;

@Repository
public class BrdDao{
	
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	/**
	 * 
	 * @Method Name	: selBrdPaging
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시판 페이징 조회
	 */
	public List selBrdPaging(Map map) throws SQLException{
		int skipResult	=	Integer.parseInt((String)map.get(CommonConfig.COMMON_SKIP_RESULT));
		int maxResult	=	Integer.parseInt((String)map.get(CommonConfig.COMMON_MAX_RESULT));
		return sqlMapClientTemplate.queryForList("brd.selBrdPaging", map, skipResult, maxResult);
	}		
	
	/**
	 * 
	 * @Method Name	: selBrdPagingCount
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시판 페이징 카운트
	 */
	public int selBrdPagingCount(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("brd.selBrdPagingCount", map);
	}
	
	/**
	 * 
	 * @Method Name	: selBrdReplyList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 댓글 리스트 조회
	 */
	public List selBrdReplyList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("brd.selBrdReplyList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insBrd01
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 등록
	 */
	public int insBrd01(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.insert("brd.insBrd01", map);
	}		
	
	/**
	 * 
	 * @Method Name	: updBrd01
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 수정
	 */
	public int updBrd01(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("brd.updBrd01", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delBrd01
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 삭제
	 */
	public int delBrd01(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("brd.delBrd01", map);
	}

	/**
	 * 
	 * @Method Name	: selBrdAttachList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시판 첨부 파일 조회
	 */
	public List selBrdAttachList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("brd.selBrdAttachList", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insBrd02
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 첨부파일 등록
	 */
	public Object insBrd02(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("brd.insBrd02", map);
	}
	
	/**
	 * 
	 * @Method Name	: delBrd02
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시글 첨부파일 삭제
	 */
	public int delBrd02(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("brd.delBrd02", map);
	}	
	
	/**
	 * 
	 * @Method Name	: selBrdKindList
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시판 종류 조회
	 */
	public List selBrdKindList(Map map) throws SQLException{
		return sqlMapClientTemplate.queryForList("brd.selBrdKindList", map);
	}
		
	/**
	 * 
	 * @Method Name	: selBrdKindExist
	 * @author	: 이상오
	 * @date	: 2016. 6. 21.
	 * 처리내용	: 게시판종류 중복 확인
	 */
	public int selBrdKindExist(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.queryForObject("brd.selBrdKindExist", map);
	}	
	
	/**
	 * 
	 * @Method Name	: insBrd04
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시판종류 등록
	 */
	public Object insBrd04(Map map) throws SQLException{
		return sqlMapClientTemplate.insert("brd.insBrd04", map);
	}		
	
	/**
	 * 
	 * @Method Name	: updBrd04
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시판종류 수정
	 */
	public int updBrd04(Map map) throws SQLException{
		return (Integer)sqlMapClientTemplate.update("brd.updBrd04", map);
	}	
	
	/**
	 * 
	 * @Method Name	: delBrd04
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시종류 삭제
	 */
	public int delBrd04(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("brd.delBrd04", map);
	}
	
	/**
	 * 
	 * @Method Name	: delBrd03BrdSeq
	 * @author	: 이상오
	 * @date	: 2016. 6. 25.
	 * 처리내용	: 게시댓글 brd_seq 조건 삭제
	 */
	public int delBrd03BrdSeq(Map map) throws SQLException{		
		return (Integer)sqlMapClientTemplate.delete("brd.delBrd03BrdSeq", map);
	}	
}
