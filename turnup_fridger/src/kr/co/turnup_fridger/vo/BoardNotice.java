package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import kr.co.turnup_fridger.util.DateJSONSerializer;



public class BoardNotice implements Serializable
{
	private int id;
	private String items;
	private String title;
	private String txt;
	private String img;//원래이름
	private String saveImg; //UUID로 생성한 이름 - 파일명 중복을 피하기 위해
	@JsonSerialize(using=DateJSONSerializer.class)
	private Date date;
	private MultipartFile upImage;
	
	public BoardNotice (){}

	public BoardNotice(int id, String items, String title, String txt, String img, String saveImg, Date date) {
		super();
		this.id = id;
		this.items = items;
		this.title = title;
		this.txt = txt;
		this.img = img;
		this.saveImg = saveImg;
		this.date = date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getItems() {
		return items;
	}

	public void setItems(String items) {
		this.items = items;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTxt() {
		return txt;
	}

	public void setTxt(String txt) {
		this.txt = txt;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getSaveImg() {
		return saveImg;
	}

	public void setSaveImg(String saveImg) {
		this.saveImg = saveImg;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public MultipartFile getUpImage() {
		return upImage;
	}

	public void setUpImage(MultipartFile upImage) {
		this.upImage = upImage;
	}



	@Override
	public String toString() {
		return "BoardNotice [id=" + id + ", items=" + items + ", title=" + title + ", txt=" + txt + ", img=" + img
				+ ", saveImg=" + saveImg + ", date=" + date + ", upImage=" + upImage + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result + id;
		result = prime * result + ((img == null) ? 0 : img.hashCode());
		result = prime * result + ((items == null) ? 0 : items.hashCode());
		result = prime * result + ((saveImg == null) ? 0 : saveImg.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + ((txt == null) ? 0 : txt.hashCode());
		result = prime * result + ((upImage == null) ? 0 : upImage.hashCode());
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
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (id != other.id)
			return false;
		if (img == null) {
			if (other.img != null)
				return false;
		} else if (!img.equals(other.img))
			return false;
		if (items == null) {
			if (other.items != null)
				return false;
		} else if (!items.equals(other.items))
			return false;
		if (saveImg == null) {
			if (other.saveImg != null)
				return false;
		} else if (!saveImg.equals(other.saveImg))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (txt == null) {
			if (other.txt != null)
				return false;
		} else if (!txt.equals(other.txt))
			return false;
		if (upImage == null) {
			if (other.upImage != null)
				return false;
		} else if (!upImage.equals(other.upImage))
			return false;
		return true;
	}

	
}