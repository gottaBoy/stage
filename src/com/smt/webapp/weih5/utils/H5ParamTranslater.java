package com.smt.webapp.weih5.utils;

public class H5ParamTranslater {

	public static String translateSexStr(String sexStr) {
		if ("男".equals(sexStr)) {
			return "1";
		} else if ("女".equals(sexStr)) {
			return "2";
		} else if ("组合".equals(sexStr)) {
			return "3";
		} else {
			return "0";
		}
	}
}
