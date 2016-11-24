package com.smt.common;


public class StageVariale {
	public final static String title = "第一舞台-找演员|找模特|找音乐人|找舞蹈|找歌手|找达人|找幕后|找艺人|中国演艺人才在线交易平台";
	public final static String title1 = "第一舞台-找演员|找模特|找音乐人|找舞蹈|找歌手|找达人|找幕后|找导演|中国演艺人才在线交易平台";
	public final static String title2 = "第一舞台-演员招募|演员培训|演员交易|演员资料|群众演员|影视演员|跟组演员|中国演艺人才在线交易平台";
	public final static String title3 = "第一舞台-音乐|摇滚音乐|传统音乐|轻音乐|戏曲|歌剧|音乐会|MV|歌手|中国演艺人才在线交易平台";
	public final static String title4 = "第一舞台-古典舞|民族舞|芭蕾舞|现代舞|当代舞|少儿舞蹈|幼儿舞|踢踏舞|广场舞|中国演艺人才在线交易平台";
	public final static String title5 = "第一舞台-特定人物模特|产品形象模特|试衣模特礼模|人体模特|表演模特|平面模特|T台模特|中国演艺人才在线交易平台";
	public final static String title6 = "第一舞台-极限|武术|牛人|模仿秀|网络达人|网络牛人|中国演艺人才在线交易平台";
	public final static String title7 = "第一舞台-灯光|服装|道具|化妆|导演|编剧|美术|策划|摄影|摄像|中国演艺人才在线交易平台";
	public final static String description = "第1舞台";
	public static String  getProfById(String id){
		int profId = Integer.parseInt(id);
		switch (profId) {
		case 0://新人加入
			return "机构";
		case 1://新人加入
			return "新人加入";
		case 2://演员
			return "演员";
		case 3://音乐
			return "音乐";
		case 5://模特
			return "模特";
		case 4://舞蹈
			return "舞蹈";
		case 6://达人
			return "达人";		
		case 7://幕后
			return "幕后制作";
		}
		return id;
	}
	public static String  getEnProfById(String id){
		int profId = Integer.parseInt(id);
		switch (profId) {
		case 0://机构
			return "ORGANIZATION";
		case 1://新人加入
			return "NEW";
		case 2://演员
			return "ACTOR";
		case 3://音乐
			return "MUSIC";
		case 5://模特
			return "MODEL";
		case 4://舞蹈
			return "DANCE";
		case 6://达人
			return "TALENT";		
		case 7://幕后
			return "BACKSTAGE";
		}
		return id;
	}
	
	public static String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	}
}
