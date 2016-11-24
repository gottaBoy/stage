package com.smt.webapp.weih5.utils;

import java.util.Random;

public class H5ValidCodeHelper {

	public static int generate() {
		return nextInt(1000, 9999);
	}

	private static int nextInt(final int min, final int max) {
		Random rand;
		rand = new Random();
		int tmp = Math.abs(rand.nextInt());
		return tmp % (max - min + 1) + min;
	}
}
