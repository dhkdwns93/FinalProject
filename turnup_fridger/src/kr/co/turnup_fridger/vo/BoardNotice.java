package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;



public class BoardNotice implements Serializable
{
	private int boardNoticeId;
	private String boardNoticeItems;
	private String boardNoticeTitle;
	private String boardNoticeTxt;
	private String boardNoticeImg;
	private Date date;
	
	public BoardNotice (){}

	public BoardNotice(int boardNoticeId, String boardNoticeItems, String boardNoticeTitle, String boardNoticeTxt,
			String boardNoticeImg, Date date) {
		this.boardNoticeId = boardNoticeId;
		this.boardNoticeItems = boardNoticeItems;
		this.boardNoticeTitle = boardNoticeTitle;
		this.boardNoticeTxt = boardNoticeTxt;
		this.boardNoticeImg = boardNoticeImg;
		this.date = date;
	}

	public int getBoardNoticeId() {
		return boardNoticeId;
	}

	public void setBoardNoticeId(int boardNoticeId) {
		this.boardNoticeId = boardNoticeId;
	}

	public String getBoardNoticeItems() {
		return boardNoticeItems;
	}

	public void setBoardNoticeItems(String boardNoticeItems) {
		this.boardNoticeItems = boardNoticeItems;
	}

	public String getBoardNoticeTitle() {
		return boardNoticeTitle;
	}

	public void setBoardNoticeTitle(String boardNoticeTitle) {
		this.boardNoticeTitle = boardNoticeTitle;
	}

	public String getBoardNoticeTxt() {
		return boardNoticeTxt;
	}

	public void setBoardNoticeTxt(String boardNoticeTxt) {
		this.boardNoticeTxt = boardNoticeTxt;
	}

	public String getBoardNoticeImg() {
		return boardNoticeImg;
	}

	public void setBoardNoticeImg(String boardNoticeImg) {
		this.boardNoticeImg = boardNoticeImg;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "BoardNotice [boardNoticeId=" + boardNoticeId + ", boardNoticeItems=" + boardNoticeItems
				+ ", boardNoticeTitle=" + boardNoticeTitle + ", boardNoticeTxt=" + boardNoticeTxt + ", boardNoticeImg="
				+ boardNoticeImg + ", date=" + date + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + boardNoticeId;
		result = prime * result + ((boardNoticeImg == null) ? 0 : boardNoticeImg.hashCode());
		result = prime * result + ((boardNoticeItems == null) ? 0 : boardNoticeItems.hashCode());
		result = prime * result + ((boardNoticeTitle == null) ? 0 : boardNoticeTitle.hashCode());
		result = prime * result + ((boardNoticeTxt == null) ? 0 : boardNoticeTxt.hashCode());
		result = prime * result + ((date == null) ? 0 : date.hashCode());
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
		BoardNotice other = (BoardNotice) obj;
		if (boardNoticeId != other.boardNoticeId)
			return false;
		if (boardNoticeImg == null) {
			if (other.boardNoticeImg != null)
				return false;
		} else if (!boardNoticeImg.equals(other.boardNoticeImg))
			return false;
		if (boardNoticeItems == null) {
			if (other.boardNoticeItems != null)
				return false;
		} else if (!boardNoticeItems.equals(other.boardNoticeItems))
			return false;
		if (boardNoticeTitle == null) {
			if (other.boardNoticeTitle != null)
				return false;
		} else if (!boardNoticeTitle.equals(other.boardNoticeTitle))
			return false;
		if (boardNoticeTxt == null) {
			if (other.boardNoticeTxt != null)
				return false;
		} else if (!boardNoticeTxt.equals(other.boardNoticeTxt))
			return false;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		return true;
	}

}