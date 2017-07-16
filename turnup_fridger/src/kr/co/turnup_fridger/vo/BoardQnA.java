package kr.co.turnup_fridger.vo;

import java.util.Date;
import java.util.List;

public class BoardQnA 
{
	private int boardQnAId;
	private String boardQnATitle;
	private String boardQnATxt;
	private Date boardQnAdate;
	private int commentCount;
	private String memberId;
	private Member member;
	private List<CommentQnA> commentQnAList;
	
	public BoardQnA(){}

	public BoardQnA(int boardQnAId, String boardQnATitle, String boardQnATxt, Date boardQnAdate, int commentCount,
			String memberId) {
		super();
		this.boardQnAId = boardQnAId;
		this.boardQnATitle = boardQnATitle;
		this.boardQnATxt = boardQnATxt;
		this.boardQnAdate = boardQnAdate;
		this.commentCount = commentCount;
		this.memberId = memberId;
	}

	public int getBoardQnAId() {
		return boardQnAId;
	}

	public void setBoardQnAId(int boardQnAId) {
		this.boardQnAId = boardQnAId;
	}

	public String getBoardQnATitle() {
		return boardQnATitle;
	}

	public void setBoardQnATitle(String boardQnATitle) {
		this.boardQnATitle = boardQnATitle;
	}

	public String getBoardQnATxt() {
		return boardQnATxt;
	}

	public void setBoardQnATxt(String boardQnATxt) {
		this.boardQnATxt = boardQnATxt;
	}

	public Date getBoardQnAdate() {
		return boardQnAdate;
	}

	public void setBoardQnAdate(Date boardQnAdate) {
		this.boardQnAdate = boardQnAdate;
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

	public List<CommentQnA> getCommentQnAList() {
		return commentQnAList;
	}

	public void setCommentQnAList(List<CommentQnA> commentQnAList) {
		this.commentQnAList = commentQnAList;
	}
	
	
	
	@Override
	public String toString() {
		return "BoardQnA [boardQnAId=" + boardQnAId + ", boardQnATitle=" + boardQnATitle + ", boardQnATxt="
				+ boardQnATxt + ", boardQnAdate=" + boardQnAdate + ", commentCount=" + commentCount + ", memberId="
				+ memberId + ", member=" + member + ", commentQnAList=" + commentQnAList + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + boardQnAId;
		result = prime * result + ((boardQnATitle == null) ? 0 : boardQnATitle.hashCode());
		result = prime * result + ((boardQnATxt == null) ? 0 : boardQnATxt.hashCode());
		result = prime * result + ((boardQnAdate == null) ? 0 : boardQnAdate.hashCode());
		result = prime * result + commentCount;
		result = prime * result + ((commentQnAList == null) ? 0 : commentQnAList.hashCode());
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
		BoardQnA other = (BoardQnA) obj;
		if (boardQnAId != other.boardQnAId)
			return false;
		if (boardQnATitle == null) {
			if (other.boardQnATitle != null)
				return false;
		} else if (!boardQnATitle.equals(other.boardQnATitle))
			return false;
		if (boardQnATxt == null) {
			if (other.boardQnATxt != null)
				return false;
		} else if (!boardQnATxt.equals(other.boardQnATxt))
			return false;
		if (boardQnAdate == null) {
			if (other.boardQnAdate != null)
				return false;
		} else if (!boardQnAdate.equals(other.boardQnAdate))
			return false;
		if (commentCount != other.commentCount)
			return false;
		if (commentQnAList == null) {
			if (other.commentQnAList != null)
				return false;
		} else if (!commentQnAList.equals(other.commentQnAList))
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
