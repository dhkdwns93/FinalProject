package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import kr.co.turnup_fridger.util.DateJSONSerializer;

public class BoardFree implements Serializable{

	private int boardFreeId;
	private String boardFreeTitle;
	private String boardFreeTxt;
	@JsonSerialize(using=DateJSONSerializer.class)
	private Date date;
	private int boardFreeHits;
	private int commentCount;
	
	private String memberId;
	private Member member;
	
	private List<CommentFree> commentFree;

	public BoardFree(){}

	public BoardFree(int boardFreeId, String boardFreeTitle, String boardFreeTxt, Date date, int boardFreeHits,
			int commentCount, String memberId) {
		super();
		this.boardFreeId = boardFreeId;
		this.boardFreeTitle = boardFreeTitle;
		this.boardFreeTxt = boardFreeTxt;
		this.date = date;
		this.boardFreeHits = boardFreeHits;
		this.commentCount = commentCount;
		this.memberId = memberId;
	}

	public int getBoardFreeId() {
		return boardFreeId;
	}

	public void setBoardFreeId(int boardFreeId) {
		this.boardFreeId = boardFreeId;
	}

	public String getBoardFreeTitle() {
		return boardFreeTitle;
	}

	public void setBoardFreeTitle(String boardFreeTitle) {
		this.boardFreeTitle = boardFreeTitle;
	}

	public String getBoardFreeTxt() {
		return boardFreeTxt;
	}

	public void setBoardFreeTxt(String boardFreeTxt) {
		this.boardFreeTxt = boardFreeTxt;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getBoardFreeHits() {
		return boardFreeHits;
	}

	public void setBoardFreeHits(int boardFreeHits) {
		this.boardFreeHits = boardFreeHits;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
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

	public List<CommentFree> getCommentFree() {
		return commentFree;
	}

	public void setCommentFree(List<CommentFree> commentFree) {
		this.commentFree = commentFree;
	}

	@Override
	public String toString() {
		return "BoardFree [boardFreeId=" + boardFreeId + ", boardFreeTitle=" + boardFreeTitle + ", boardFreeTxt="
				+ boardFreeTxt + ", date=" + date + ", boardFreeHits=" + boardFreeHits + ", commentCount="
				+ commentCount + ", memberId=" + memberId + ", member=" + member + ", commentFree=" + commentFree + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + boardFreeHits;
		result = prime * result + boardFreeId;
		result = prime * result + ((boardFreeTitle == null) ? 0 : boardFreeTitle.hashCode());
		result = prime * result + ((boardFreeTxt == null) ? 0 : boardFreeTxt.hashCode());
		result = prime * result + commentCount;
		result = prime * result + ((commentFree == null) ? 0 : commentFree.hashCode());
		result = prime * result + ((date == null) ? 0 : date.hashCode());
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
		BoardFree other = (BoardFree) obj;
		if (boardFreeHits != other.boardFreeHits)
			return false;
		if (boardFreeId != other.boardFreeId)
			return false;
		if (boardFreeTitle == null) {
			if (other.boardFreeTitle != null)
				return false;
		} else if (!boardFreeTitle.equals(other.boardFreeTitle))
			return false;
		if (boardFreeTxt == null) {
			if (other.boardFreeTxt != null)
				return false;
		} else if (!boardFreeTxt.equals(other.boardFreeTxt))
			return false;
		if (commentCount != other.commentCount)
			return false;
		if (commentFree == null) {
			if (other.commentFree != null)
				return false;
		} else if (!commentFree.equals(other.commentFree))
			return false;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
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
