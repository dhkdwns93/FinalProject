package kr.co.turnup_fridger.util;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AmountChangeMain {
	public static void main(String[] args){
		String str = "* 땅콩버터소스 : 땅콩버터 2큰술, 꿀 1큰술, 설탕 1큰술, 식초 3/2큰술, 깨소금 1큰술, 레몬즙 123큰술";
		str = "100kg";
		String result = amountChange(str);
		String result2 = amountChangeIrdnt(str);
		System.out.println(result2);
		//System.out.println("결과 출력은!!!!--->"+result2);
		
	}

//	public static String amountChange(String str){
//		//단위 조사한 것
//		String danwi = "개/T/컵/잎/대/g/장/공기/마리/알/ml/쪽/모/줄기/큐브/단/토막/조각/뿌리/큰술/작은술/포기/톨/kg/ml/봉/통/L/묶음/되/덩이/캔/cc/관/단/근/C/쪽";
//		String[] danwiArr = danwi.split("/");
//		//System.out.println("danwiArr:"+Arrays.toString(danwiArr));
//		StringBuffer sb = new StringBuffer(str);
//		int idx = 0;
//		char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' };
//		
//		outer:
//		while(str.trim().length() != 0){
//			for (String dan : danwiArr) {
//				idx = str.lastIndexOf(dan);
//				//System.out.println(dan);
//				//System.out.println(idx);
//				//System.out.println(str);
//				if(idx != -1) {
//					sb.insert(idx, "</span>"); // 오픈태그 넣고 넣자
//					//System.out.println("sb:" + sb);
//					//System.out.println("idx:" + idx);
//					// System.out.println("str.charAt(--idx):"+str.charAt(--idx));
//					--idx;
//					inner:
//					for (int i = idx; i >= 0; i--) {
//						for (int p = 0; p < pattern.length; p++) {
//							//System.out.println("str.charAt(" + i + "):" + str.charAt(i) + "/pattern[" + p + "]:" + pattern[p]);
//							if (str.charAt(i) == pattern[p]) {
//								//System.out.println("일치str.charAt(i):" + str.charAt(i));
//								if(i==0){
//									sb.insert(i, "<span>");
//									break outer;
//								}
//								continue inner;
//							}
//						}
//						//i번째 인댁스에서 해당 값이 없으면 ...스판태그 닫기 
//						sb.insert(i+1, "<span>");
//						//System.out.println("sb:" + sb);
//						String temp = str.substring(0, i);
//						str = temp;
//						//System.out.println("줄어든str:"+str);
//						continue outer;
//					}
//	
//				}
//			}
//		str = "";	//문자열 길이 0으로 만들기
//		}
//	//	System.out.println("최종sb:"+ sb);
//		return sb.toString();
//	}

	
	
	public static String amountChange(String str){
		//단위 조사한 것
		String danwi = "kg/개/T/컵/잎/대/g/장/공기/마리/알/ml/쪽/모/줄기/큐브/단/토막/조각/뿌리/큰술/작은술/포기/톨/ml/봉/통/L/묶음/되/덩이/캔/cc/관/단/근/C/쪽";
		String[] danwiArr = danwi.split("/");
		//System.out.println("danwiArr:"+Arrays.toString(danwiArr));
		StringBuffer sb = new StringBuffer(str);
		int idx = 0;
		char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' };
		
		outer:
		while(str.trim().length() != 0){
			for (String dan : danwiArr) {
				idx = str.lastIndexOf(dan);
				//System.out.println(dan);
				//System.out.println(idx);
				//System.out.println(str);
				if(idx != -1) {
					sb.insert(idx, "</span>"); // 오픈태그 넣고 넣자
					//System.out.println("sb:" + sb);
					//System.out.println("idx:" + idx);
					// System.out.println("str.charAt(--idx):"+str.charAt(--idx));
					--idx;
					inner:
					for (int i = idx; i >= 0; i--) {
						for (int p = 0; p < pattern.length; p++) {
							//System.out.println("str.charAt(" + i + "):" + str.charAt(i) + "/pattern[" + p + "]:" + pattern[p]);
							if (str.charAt(i) == pattern[p]) {
								//System.out.println("일치str.charAt(i):" + str.charAt(i));
			
								if(i==0){
									sb.insert(i, "<span class='amountChangable'>");
									break outer;
								}
								continue inner;
							}
						}
						//i번째 인댁스에서 해당 값이 없으면 ...스판태그 닫기 
						if((idx-i)==1){
							sb.replace(i+1, i+7, "");
							continue outer;
						}else{
							sb.insert(i+1, "<span class='amountChangable'>");
						}
						//System.out.println("sb:" + sb);
						String temp = str.substring(0, i);
						str = temp;
						//System.out.println("줄어든str:"+str);
						continue outer;
					}
	
				}
			}
		str = "";	//문자열 길이 0으로 만들기
		}
	//	System.out.println("최종sb:"+ sb);
		return sb.toString();
	}
	
	
	public static String amountChangeIrdnt(String str){
		//단위 조사한 것
		String danwi = "kg/개/T/컵/잎/대/g/장/공기/마리/알/ml/쪽/모/줄기/큐브/단/토막/조각/뿌리/큰술/작은술/포기/톨/ml/봉/통/L/묶음/되/덩이/캔/cc/관/단/근/C/쪽";
		String[] danwiArr = danwi.split("/");
		//System.out.println("danwiArr:"+Arrays.toString(danwiArr));
		StringBuffer sb = new StringBuffer(str);
		int idx = 0;
		char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' };
		outer:
		for (String dan : danwiArr) {
				idx = str.lastIndexOf(dan);
				if(idx != -1) {
					sb.insert(idx, "</span>"); // 오픈태그 넣고 넣자
					//System.out.println("sb:" + sb);
					//System.out.println("idx:" + idx);
					// System.out.println("str.charAt(--idx):"+str.charAt(--idx));
					--idx;
					inner:
					for (int i = idx; i >= 0; i--) {
						for (int p = 0; p < pattern.length; p++) {
							//System.out.println("str.charAt(" + i + "):" + str.charAt(i) + "/pattern[" + p + "]:" + pattern[p]);
							if (str.charAt(i) == pattern[p]) {
								//System.out.println("일치str.charAt(i):" + str.charAt(i));
			
								if(i==0){
									sb.insert(i, "<span class='amountChangable'>");
									break outer;
								}
								continue inner;
							}
						}
					}
	
				}
			}
		
	//	System.out.println("최종sb:"+ sb);
		return sb.toString();
	}


}		
		
	

