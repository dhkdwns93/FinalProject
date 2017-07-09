package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.vo.CommentFree;

public interface CommentFreeService  {

	void addCommentFree(CommentFree commentFree);
	void updateCommentFree(CommentFree commentFree);
	void removeCommentFree(int id);
	Map<String, Object> selectCommentFreeListbyId(int id,int page);
}
