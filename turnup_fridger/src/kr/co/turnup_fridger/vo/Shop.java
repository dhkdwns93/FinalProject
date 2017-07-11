package kr.co.turnup_fridger.vo;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

public class Shop implements Serializable{

	private int shopId;
	private String shopName;
	private String shopAddress;
	private String shopImg;
	private String saveImg; //UUID
	private MultipartFile upImage;
	
	public Shop(){}
	
	public Shop(int shopId, String shopName, String shopAddress) {
		super();
		this.shopId = shopId;
		this.shopName = shopName;
		this.shopAddress = shopAddress;
	}



	public Shop(String shopName, String shopAddress, MultipartFile upImage) {
		super();
		this.shopName = shopName;
		this.shopAddress = shopAddress;
		this.upImage = upImage;
	}



	public Shop(int shopId, String shopName, String shopAddress, String shopImg, String saveImg) {
		super();
		this.shopId = shopId;
		this.shopName = shopName;
		this.shopAddress = shopAddress;
		this.shopImg = shopImg;
		this.saveImg = saveImg;
	}

	
	public int getShopId() {
		return shopId;
	}
	public void setShopId(int shopId) {
		this.shopId = shopId;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getShopAddress() {
		return shopAddress;
	}
	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}
	public String getShopImg() {
		return shopImg;
	}
	public void setShopImg(String shopImg) {
		this.shopImg = shopImg;
	}

	public String getSaveImg() {
		return saveImg;
	}

	public void setSaveImg(String saveImg) {
		this.saveImg = saveImg;
	}

	public MultipartFile getUpImage() {
		return upImage;
	}

	public void setUpImage(MultipartFile upImage) {
		this.upImage = upImage;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((saveImg == null) ? 0 : saveImg.hashCode());
		result = prime * result + ((shopAddress == null) ? 0 : shopAddress.hashCode());
		result = prime * result + shopId;
		result = prime * result + ((shopImg == null) ? 0 : shopImg.hashCode());
		result = prime * result + ((shopName == null) ? 0 : shopName.hashCode());
		result = prime * result + ((upImage == null) ? 0 : upImage.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Shop))
			return false;
		Shop other = (Shop) obj;
		if (saveImg == null) {
			if (other.saveImg != null)
				return false;
		} else if (!saveImg.equals(other.saveImg))
			return false;
		if (shopAddress == null) {
			if (other.shopAddress != null)
				return false;
		} else if (!shopAddress.equals(other.shopAddress))
			return false;
		if (shopId != other.shopId)
			return false;
		if (shopImg == null) {
			if (other.shopImg != null)
				return false;
		} else if (!shopImg.equals(other.shopImg))
			return false;
		if (shopName == null) {
			if (other.shopName != null)
				return false;
		} else if (!shopName.equals(other.shopName))
			return false;
		if (upImage == null) {
			if (other.upImage != null)
				return false;
		} else if (!upImage.equals(other.upImage))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Shop [shopId=" + shopId + ", shopName=" + shopName + ", shopAddress=" + shopAddress + ", shopImg="
				+ shopImg + ", saveImg=" + saveImg + ", upImage=" + upImage + "]";
	}

}
