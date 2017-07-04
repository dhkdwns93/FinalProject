package kr.co.turnup_fridger.validation.form;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotEmpty;

public class ShopForm implements Serializable{

	private int shopId;
	@NotEmpty(message ="쇼핑몰 이름은 필수항목입니다.")
	private String shopName;
	@NotEmpty(message ="쇼핑몰 주소는 필수항목입니다.")
	private String shopAddress;
	private String shopImage;
	
	
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
	public String getShopImage() {
		return shopImage;
	}
	public void setShopImage(String shopImage) {
		this.shopImage = shopImage;
	}
	
}
