package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.CommentFreeDao;
import kr.co.turnup_fridger.service.CommentFreeService;
import kr.co.turnup_fridger.util.PagingBeanComment;
import kr.co.turnup_fridger.vo.CommentFree;

@Service
public class CommentFreeServiceImpl implements CommentFreeService{

	@Autowired
	private CommentFreeDao dao;

	@Override
	public void addCommentFree(CommentFree commentFree) {
		dao.insertCommentFree(commentFree);
		
	}
	
	
	@Override
	public void updateCommentFree(CommentFree commentFree) {
		dao.updateCommentFree(commentFree);
		
	}


	@Override
	public void removeCommentFree(int id) {
		dao.deleteCommentFree(id);
		
	}


	@Override
	public Map<String, Object> selectCommentFreeListbyId(int boardFreeId,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectCommentFreeCount(boardFreeId);
		PagingBeanComment pageBean = new PagingBeanComment(totalCount, page);
		map.put("pageBean", pageBean);
		List<CommentFree> list = dao.selectCommentFreeListbyId(boardFreeId, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("boardFreeId", boardFreeId);
		map.put("list", list);
		
		return map;
	}


	@Override
	public CommentFree selectCommentFreeById(int commentFreeId) {
		// TODO Auto-generated method stub
		return dao.selectCommentFreeById(commentFreeId);
	}

	

	
	
}
