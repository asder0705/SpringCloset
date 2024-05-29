package com.love.my.member.vo;

public class MemberVO {

	private String memId;
	private String memPw;
	private String memNm;
	private int memCm;
	private int memKg;
	private String memSty;
	private String useYn;
	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemPw() {
		return memPw;
	}
	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public int getMemCm() {
		return memCm;
	}
	public void setMemCm(int memCm) {
		this.memCm = memCm;
	}
	public int getMemKg() {
		return memKg;
	}
	public void setMemKg(int memKg) {
		this.memKg = memKg;
	}
	public String getMemSty() {
		return memSty;
	}
	public void setMemSty(String memSty) {
		this.memSty = memSty;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPw=" + memPw + ", memNm=" + memNm + ", memCm="
				+ memCm +", memKg=" + memKg + ", memSty=" + memSty + ", useYn=" + useYn + "]";
	}
}
