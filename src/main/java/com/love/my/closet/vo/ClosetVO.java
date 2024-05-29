package com.love.my.closet.vo;

public class ClosetVO {

	 private String pcode;
	 private int qty;
	 private String pname;
	 private String pnameKr;
	 private String ptypeName;
	 private String pgroupName;
	 private String gappName;
	 private String detailDesc;
	 private int price;
	 private String cgroupCode;
	 private String cgroupName;
	 private String imgPath;
	 private String memId;
	 private String closetNo;
	 
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPnameKr() {
		return pnameKr;
	}
	public void setPnameKr(String pnameKr) {
		this.pnameKr = pnameKr;
	}
	public String getPtypeName() {
		return ptypeName;
	}
	public void setPtypeName(String ptypeName) {
		this.ptypeName = ptypeName;
	}
	public String getPgroupName() {
		return pgroupName;
	}
	public void setPgroupName(String pgroupName) {
		this.pgroupName = pgroupName;
	}
	public String getGappName() {
		return gappName;
	}
	public void setGappName(String gappName) {
		this.gappName = gappName;
	}
	public String getDetailDesc() {
		return detailDesc;
	}
	public void setDetailDesc(String detailDesc) {
		this.detailDesc = detailDesc;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCgroupCode() {
		return cgroupCode;
	}
	public void setCgroupCode(String cgroupCode) {
		this.cgroupCode = cgroupCode;
	}
	public String getCgroupName() {
		return cgroupName;
	}
	public void setCgroupName(String cgroupName) {
		this.cgroupName = cgroupName;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getClosetNo() {
		return closetNo;
	}
	public void setClosetNo(String closetNo) {
		this.closetNo = closetNo;
	}
	@Override
	public String toString() {
		return "ClosetVO [pcode=" + pcode + ", qty=" + qty + ", pname=" + pname + ", pnameKr=" + pnameKr
				+ ", ptypeName=" + ptypeName + ", pgroupName=" + pgroupName + ", gappName=" + gappName + ", detailDesc="
				+ detailDesc + ", price=" + price + ", cgroupCode=" + cgroupCode + ", cgroupName=" + cgroupName
				+ ", imgPath=" + imgPath + ", memId=" + memId + ", closetNo=" + closetNo + "]";
	}
	
	 
	
	
}
