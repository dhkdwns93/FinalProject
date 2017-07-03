package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class Shop implements Serializable{

	private int shopId;
	private String shopName;
	private String shopAddress;
	private String shopImg;
	
	public Shop(){}
	public Shop(int shopId, String shopName, String shopAddress, String shopImg) {
		super();
		this.shopId = shopId;
		this.shopName = shopName;
		this.shopAddress = shopAddress;
		this.shopImg = shopImg;
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((shopAddress == null) ? 0 : shopAddress.hashCode());
		result = prime * result + shopId;
		result = prime * result + ((shopImg == null) ? 0 : shopImg.hashCode());
		result = prime * result + ((shopName == null) ? 0 : shopName.hashCode());
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
		return true;
	}
	@Override
	public String toString() {
		return "Shop [shopId=" + shopId + ", shopName=" + shopName + ", shopAddress=" + shopAddress + ", shopImg="
				+ shopImg + "]";
	}
	
	
}
