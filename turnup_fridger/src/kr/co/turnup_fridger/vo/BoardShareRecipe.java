package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class BoardShareRecipe implements Serializable{
	private int recipeId; //레시피 공유 ID
	private String title; //제목
	private String txt;	//내용
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date date;	//작성일
	private int recommand; 	//추천수
	private int hits;	//조회수
	private String etc;	 //기타재료
	private String saveName;//이클립스가 저장하는 이름
	private String original;//원래이름
	
	
	private String memberId;	//회원ID
	private Member member;//회원 객체
	
	//사진
	private MultipartFile upImage;
	
	//Join
	private List<MemberRecipeRecommand>memberRecommand;//추천현황 객체
	private List<ShareRecipeIrdnt> shareRecipeIrdnt;//재료명 객체
	
	
	public BoardShareRecipe(){
		
	}
	
	
	

	public BoardShareRecipe(String title, String txt, String etc, MultipartFile upImage,
			List<ShareRecipeIrdnt> shareRecipeIrdnt) {
		super();
		this.title = title;
		this.txt = txt;
		this.etc = etc;
		this.upImage = upImage;
		this.shareRecipeIrdnt = shareRecipeIrdnt;
	}




	public BoardShareRecipe(int recipeId, String title, String txt, Date date, int recommand, int hits, String etc,
			String saveName, String original, String memberId, Member member, MultipartFile upImage,
			List<MemberRecipeRecommand> memberRecommand, List<ShareRecipeIrdnt> shareRecipeIrdnt) {
		super();
		this.recipeId = recipeId;
		this.title = title;
		this.txt = txt;
		this.date = date;
		this.recommand = recommand;
		this.hits = hits;
		this.etc = etc;
		this.saveName = saveName;
		this.original = original;
		this.memberId = memberId;
		this.member = member;
		this.upImage = upImage;
		this.memberRecommand = memberRecommand;
		this.shareRecipeIrdnt = shareRecipeIrdnt;
	}


	public int getRecipeId() {
		return recipeId;
	}


	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
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


	public Date getDate() {
		return date;
	}


	public void setDate(Date date) {
		this.date = date;
	}


	public int getRecommand() {
		return recommand;
	}


	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}


	public int getHits() {
		return hits;
	}


	public void setHits(int hits) {
		this.hits = hits;
	}


	public String getEtc() {
		return etc;
	}


	public void setEtc(String etc) {
		this.etc = etc;
	}


	public String getSaveName() {
		return saveName;
	}


	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}


	public String getOriginal() {
		return original;
	}


	public void setOriginal(String original) {
		this.original = original;
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


	public MultipartFile getUpImage() {
		return upImage;
	}


	public void setUpImage(MultipartFile upImage) {
		this.upImage = upImage;
	}


	public List<MemberRecipeRecommand> getMemberRecommand() {
		return memberRecommand;
	}


	public void setMemberRecommand(List<MemberRecipeRecommand> memberRecommand) {
		this.memberRecommand = memberRecommand;
	}


	public List<ShareRecipeIrdnt> getShareRecipeIrdnt() {
		return shareRecipeIrdnt;
	}


	public void setShareRecipeIrdnt(List<ShareRecipeIrdnt> shareRecipeIrdnt) {
		this.shareRecipeIrdnt = shareRecipeIrdnt;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result + ((etc == null) ? 0 : etc.hashCode());
		result = prime * result + hits;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((memberRecommand == null) ? 0 : memberRecommand.hashCode());
		result = prime * result + ((original == null) ? 0 : original.hashCode());
		result = prime * result + recipeId;
		result = prime * result + recommand;
		result = prime * result + ((saveName == null) ? 0 : saveName.hashCode());
		result = prime * result + ((shareRecipeIrdnt == null) ? 0 : shareRecipeIrdnt.hashCode());
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
		BoardShareRecipe other = (BoardShareRecipe) obj;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (etc == null) {
			if (other.etc != null)
				return false;
		} else if (!etc.equals(other.etc))
			return false;
		if (hits != other.hits)
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
		if (memberRecommand == null) {
			if (other.memberRecommand != null)
				return false;
		} else if (!memberRecommand.equals(other.memberRecommand))
			return false;
		if (original == null) {
			if (other.original != null)
				return false;
		} else if (!original.equals(other.original))
			return false;
		if (recipeId != other.recipeId)
			return false;
		if (recommand != other.recommand)
			return false;
		if (saveName == null) {
			if (other.saveName != null)
				return false;
		} else if (!saveName.equals(other.saveName))
			return false;
		if (shareRecipeIrdnt == null) {
			if (other.shareRecipeIrdnt != null)
				return false;
		} else if (!shareRecipeIrdnt.equals(other.shareRecipeIrdnt))
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


	@Override
	public String toString() {
		return "BoardShareRecipe [recipeId=" + recipeId + ", title=" + title + ", txt=" + txt + ", date=" + date
				+ ", recommand=" + recommand + ", hits=" + hits + ", etc=" + etc + ", saveName=" + saveName
				+ ", original=" + original + ", memberId=" + memberId + ", member=" + member + ", upImage="
				+ upImage + ", memberRecommand=" + memberRecommand + ", shareRecipeIrdnt=" + shareRecipeIrdnt + "]";
	}
	
	
	 
	
	


	
	
	
}
