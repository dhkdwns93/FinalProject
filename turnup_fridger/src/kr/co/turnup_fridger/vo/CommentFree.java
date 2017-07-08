package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;

public class CommentFree implements Serializable{
	
	private int commentFreeId;
	private String commentFreeTxt;
	private Date commentFreedate;
	
	private int boardFreeId;
	private BoardFree boardFree;
	
	private String memberId;
	private Member member;
	
	public CommentFree(){}

	public CommentFree(int commentFreeId, String commentFreeTxt, Date commentFreedate, int boardFreeId,
			String memberId) {
		this.commentFreeId = commentFreeId;
		this.commentFreeTxt = commentFreeTxt;
		this.commentFreedate = commentFreedate;
		this.boardFreeId = boardFreeId;
		this.memberId = memberId;
	}


	public int getCommentFreeId() {
		return commentFreeId;
	}

	public void setCommentFreeId(int commentFreeId) {
		this.commentFreeId = commentFreeId;
	}

	public String getCommentFreeTxt() {
		return commentFreeTxt;
	}

	public void setCommentFreeTxt(String commentFreeTxt) {
		this.commentFreeTxt = commentFreeTxt;
	}

	public Date getCommentFreedate() {
		return commentFreedate;
	}

	public void setCommentFreedate(Date commentFreedate) {
		this.commentFreedate = commentFreedate;
	}

	public int getBoardFreeId() {
		return boardFreeId;
	}

	public void setBoardFreeId(int boardFreeId) {
		this.boardFreeId = boardFreeId;
	}

	public BoardFree getBoardFree() {
		return boardFree;
	}

	public void setBoardFree(BoardFree boardFree) {
		this.boardFree = boardFree;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "CommentFree [commentFreeId=" + commentFreeId + ", commentFreeTxt=" + commentFreeTxt
				+ ", commentFreedate=" + commentFreedate + ", boardFreeId=" + boardFreeId + ", boardFree=" + boardFree
				+ ", memberId=" + memberId + ", member=" + member + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardFree == null) ? 0 : boardFree.hashCode());
		result = prime * result + boardFreeId;
		result = prime * result + commentFreeId;
		result = prime * result + ((commentFreeTxt == null) ? 0 : commentFreeTxt.hashCode());
		result = prime * result + ((commentFreedate == null) ? 0 : commentFreedate.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CommentFree other = (CommentFree) obj;
		if (boardFree == null) {
			if (other.boardFree != null)
				return false;
		} else if (!boardFree.equals(other.boardFree))
			return false;
		if (boardFreeId != other.boardFreeId)
			return false;
		if (commentFreeId != other.commentFreeId)
			return false;
		if (commentFreeTxt == null) {
			if (other.commentFreeTxt != null)
				return false;
		} else if (!commentFreeTxt.equals(other.commentFreeTxt))
			return false;
		if (commentFreedate == null) {
			if (other.commentFreedate != null)
				return false;
		} else if (!commentFreedate.equals(other.commentFreedate))
			return false;
		if (member == null) {
			if (other.member != null)
				return false;
		} else if (!member.equals(other.member))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		return true;
	}
	
	
	
	
	
}
