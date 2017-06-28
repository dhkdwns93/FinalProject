package kr.co.turnup_fridger.vo;

import java.util.Date;

public class CommentQnA 
{
	private int commentQnAId;
	private String commentQnATxt;
	private Date commentQnADate;
	
	private String adminId;
	private Admin admin;
	
	private int boardQnAId; 
	private BoardQnA boardQnA;
	
	public CommentQnA(){}

	public CommentQnA(int commentQnAId, String commentQnATxt, Date commentQnADate, String adminId, int boardQnAId) {

		this.commentQnAId = commentQnAId;
		this.commentQnATxt = commentQnATxt;
		this.commentQnADate = commentQnADate;
		this.adminId = adminId;
		this.boardQnAId = boardQnAId;
	}

	public CommentQnA(int commentQnAId, String commentQnATxt, Date commentQnADate, String adminId, Admin admin) {
		super();
		this.commentQnAId = commentQnAId;
		this.commentQnATxt = commentQnATxt;
		this.commentQnADate = commentQnADate;
		this.adminId = adminId;
		this.admin = admin;
	}

	public CommentQnA(int commentQnAId, String commentQnATxt, Date commentQnADate, String adminId, Admin admin,
			int boardQnAId) {

		this.commentQnAId = commentQnAId;
		this.commentQnATxt = commentQnATxt;
		this.commentQnADate = commentQnADate;
		this.adminId = adminId;
		this.admin = admin;
		this.boardQnAId = boardQnAId;
	}

	public CommentQnA(int commentQnAId, String commentQnATxt, Date commentQnADate, String adminId, Admin admin,
			int boardQnAId, BoardQnA boardQnA) {
		this.commentQnAId = commentQnAId;
		this.commentQnATxt = commentQnATxt;
		this.commentQnADate = commentQnADate;
		this.adminId = adminId;
		this.admin = admin;
		this.boardQnAId = boardQnAId;
		this.boardQnA = boardQnA;
	}

	public int getCommentQnAId() {
		return commentQnAId;
	}

	public void setCommentQnAId(int commentQnAId) {
		this.commentQnAId = commentQnAId;
	}

	public String getCommentQnATxt() {
		return commentQnATxt;
	}

	public void setCommentQnATxt(String commentQnATxt) {
		this.commentQnATxt = commentQnATxt;
	}

	public Date getCommentQnADate() {
		return commentQnADate;
	}

	public void setCommentQnADate(Date commentQnADate) {
		this.commentQnADate = commentQnADate;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public int getBoardQnAId() {
		return boardQnAId;
	}

	public void setBoardQnAId(int boardQnAId) {
		this.boardQnAId = boardQnAId;
	}

	public BoardQnA getBoardQnA() {
		return boardQnA;
	}

	public void setBoardQnA(BoardQnA boardQnA) {
		this.boardQnA = boardQnA;
	}

	@Override
	public String toString() {
		return "CommentQnA [commentQnAId=" + commentQnAId + ", commentQnATxt=" + commentQnATxt + ", commentQnADate="
				+ commentQnADate + ", adminId=" + adminId + ", admin=" + admin + ", boardQnAId=" + boardQnAId
				+ ", boardQnA=" + boardQnA + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((admin == null) ? 0 : admin.hashCode());
		result = prime * result + ((adminId == null) ? 0 : adminId.hashCode());
		result = prime * result + ((boardQnA == null) ? 0 : boardQnA.hashCode());
		result = prime * result + boardQnAId;
		result = prime * result + ((commentQnADate == null) ? 0 : commentQnADate.hashCode());
		result = prime * result + commentQnAId;
		result = prime * result + ((commentQnATxt == null) ? 0 : commentQnATxt.hashCode());
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
		CommentQnA other = (CommentQnA) obj;
		if (admin == null) {
			if (other.admin != null)
				return false;
		} else if (!admin.equals(other.admin))
			return false;
		if (adminId == null) {
			if (other.adminId != null)
				return false;
		} else if (!adminId.equals(other.adminId))
			return false;
		if (boardQnA == null) {
			if (other.boardQnA != null)
				return false;
		} else if (!boardQnA.equals(other.boardQnA))
			return false;
		if (boardQnAId != other.boardQnAId)
			return false;
		if (commentQnADate == null) {
			if (other.commentQnADate != null)
				return false;
		} else if (!commentQnADate.equals(other.commentQnADate))
			return false;
		if (commentQnAId != other.commentQnAId)
			return false;
		if (commentQnATxt == null) {
			if (other.commentQnATxt != null)
				return false;
		} else if (!commentQnATxt.equals(other.commentQnATxt))
			return false;
		return true;
	}

	

}
