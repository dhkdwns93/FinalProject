package kr.co.turnup_fridger.util;

import org.springframework.stereotype.Service;

@Service
public class AmountChangeService {
	private String danwi;
	private String[] danwiArr;
	
	
	public AmountChangeService(){
		danwi = "작은술/kg/ml/cc/cup/CUP/공기/마리/줄기/큐브/토막/조각/뿌리/"
				+"큰술/포기/묶음/알/쪽/모/단/톨/봉/통/L/되/덩이/캔/관/근/C/"
				+ "쪽/개/T/컵/잎/대/g/장";
		danwiArr = danwi.split("/"); //단위 "/"를 구분자로 쪼개서 배열로 저장
		
	}
	
	public String amountChange(String str){
		
		StringBuffer sb = null;
		
		//숫자판별을 위한 배열
		char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' }; 	
		if(str != null && !str.trim().isEmpty()){
			sb = new StringBuffer(str); //문자열 사이에 새로운 문자열 삽입을 위해 사용
			int idx = 0;
			int startIdx = 0;
			int endIdx = 0;
			String tempStr = "";	// 조각 내서 검사할 때 쓰는  temp
			boolean flag = true;
			
			
			for (String dan : danwiArr) {
				//플래그 초기화
				flag =true;
				tempStr = sb.toString();	// 앞전 단위 태크처리 후 저장된 문자열로 초기화
				outer:
				while(flag){
					idx = tempStr.lastIndexOf(dan);
					if(idx != -1) {	//단위가 발견됨
						endIdx = idx;	//end tag 들어갈 곳 표시
						idx--;
						inner:
						for (int i = idx; i >= 0; i--) {
							for (int p = 0; p < pattern.length; p++) {	//각 자리를 숫자판별 패턴과 비교
								if (tempStr.charAt(i)==pattern[p]) {//숫자판별 패턴과 일치하는게 발견되면 다름 문자 비교
									continue inner;
								}
							}
							//패턴이 발견되지 않으면 
							startIdx = i+1;	// 숫자였던 곳(i+1) start tag들어갈 곳 표시	
							break;	//숫자 끝
						}
						if((endIdx-startIdx) >= 1 ){
							//시작태그 넣으면 인덱스가 밀리므로 끝태크부터 넣어주기 
							sb.insert(endIdx, "</span>");	//태그는 실제 문자열에 
							sb.insert(startIdx, "<span class='amountChangable'>");
							
						}
						//사이에 아무것도 없을 때 혹은 이미 태그가 들어가서 숫자가 아닐때
						tempStr = sb.substring(0, startIdx);// 뒤쪽 자르고  같은 단위가 또 있는지 다시 체크
						continue outer;
							
					}else{//더이상 해당 단위 포함 되어있지 않다면 다음 단위로 넘어간다.
						flag = false;
						
					}//end of if-else
				}//end of while
			}//end of for	
			return sb.toString();
		}
		return "";
		
	}
	
	
	public String amountIrdntChange(String str){
		StringBuffer sb = null;
		
		if(str != null && !str.trim().isEmpty()){
			sb = new StringBuffer(str); //문자열 사이에 새로운 문자열 삽입을 위해 사용
			int idx = 0;	
		
			for (String dan : danwiArr) {
				idx = str.lastIndexOf(dan);
				if(idx != -1) {	//단위가 발견됨
					sb.insert(idx, "</span>"); // 오픈태그 넣고 넣자
					sb.insert(0, "<span class='amountChangable'>");
					break;
				}
					
			}
		}
		return sb.toString();
	}


}		
		
	

