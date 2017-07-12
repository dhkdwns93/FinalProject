package kr.co.turnup_fridger.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertMethod {
	public void insertAPI(String fileRoot, String fileName){

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE"; // 본인 데이터베이스 설정에
																// 맞게 쓸것
			String id = "tuf"; // 본인 데이터베이스 아이디에 맞춰서 쓸것
			String pw = "turnup"; // 본인 데이터베이스 비밀번호에 맞춰서 쓸것

			Class.forName("oracle.jdbc.driver.OracleDriver");

			conn = DriverManager.getConnection(url, id, pw);
			BufferedReader in = new BufferedReader(
					new InputStreamReader(new FileInputStream(fileRoot+fileName+".txt"), "euc-kr")); // 파일경로, 인코딩타입
			
			String line;
			String[] str = null;
			String sql;//sql쿼리문 자리
			
			switch (fileName) {
			// 레시피재료정보
			case "recipe_irdnt":
				// String sql = "insert into view_tn_recipe_irdnt values(?,?,?,?,?,?)";
				sql = "insert into " + fileName + "_temp values(?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				while ((line = in.readLine()) != null) {
					str = line.split("&");
					if (str.length == 7) {// 열갯수=6
						for (int i = 0; i < str.length; i++) {
							pstmt.setString(i + 1, str[i].trim());
						}
						/*
						 * pstmt.setString(1, str[0]); 
						 * pstmt.setString(2, str[1]); 
						 * pstmt.setString(3, str[2]);
						 * pstmt.setString(4, str[3]); 
						 * pstmt.setString(5, str[4]); 
						 * pstmt.setString(6, str[5]);
						 */
						pstmt.executeUpdate();
					} else {
						System.out.println("레시피 재료 열 갯수 오류 - " + str[0]);
					}
				}
				System.out.println("재료 자료 넣기 완료");
				break;
			// 레시피 과정정보
			case "recipe_crse":
				sql = "insert into " + fileName + " values(?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				while ((line = in.readLine()) != null) {
					str = line.split("&");
					if (str.length == 5) {// 열갯수=5
						for (int i = 0; i < str.length; i++) {
							pstmt.setString(i + 1, str[i]);
						}
						pstmt.executeUpdate();
					} else {
						System.out.println("열 갯수 오류 - " + str[0]);
					}
				}
				System.out.println("레시피과정정보 자료 넣기 완료");
				break;
			// 레시피 기본정보
			case "recipe_info":
				sql = "insert into " + fileName + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				while ((line = in.readLine()) != null) {
					str = line.split("&");
					if (str.length == 16) {// 열갯수=15
						for (int i = 0; i < str.length; i++) {
							pstmt.setString(i + 1, str[i]);
						}
						pstmt.executeUpdate();
					} else {
						System.out.println("열 갯수 오류 - " + str[0]);
					}
				}
				System.out.println("레시피기본정보 자료 넣기 완료");
				break;
			//재료관리
			case "irdnt_manage":
				sql = "insert into " + fileName + " values(?,?,?,?,?,?,?)";
				System.out.println(fileName);
				int cnt = 1;
				pstmt = conn.prepareStatement(sql);
				while ((line = in.readLine()) != null) {
					str = line.split("&");

					if (str.length == 7) {// 열갯수=7
						
						pstmt.setInt(1, cnt++);//id 
						pstmt.setString(2, str[1].trim()); //name
						pstmt.setString(3, str[2].trim());//catregory
						pstmt.setInt(4,Integer.parseInt(str[3].trim())); //room
						pstmt.setInt(5,Integer.parseInt(str[4].trim())); //cold
						pstmt.setInt(6,Integer.parseInt(str[5].trim())); //freeze
						pstmt.setString(7,str[6].trim() ); //note
												
						pstmt.executeUpdate();
					} else {
						System.out.println("열 갯수 오류 - " + str[0]);
					}
				}
				System.out.println("재료관리 자료 넣기 완료");
				break;	
				
			// 다른파일
			default:
				System.out.println("파일명확인");
			}//end of switch
			in.close();

		} catch (Exception e) {
			System.err.println(e);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException sqle) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
		}
	}
}
