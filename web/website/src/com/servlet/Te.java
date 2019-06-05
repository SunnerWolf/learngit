package com.servlet;

public class Te {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String a = "黄牛破解12306网站限制 10分钟刷";
		byte[] aa = a.getBytes();
		System.out.println(aa.length);
		int titleSize = 48;
		String str = "合肥of猴儿豪富哦二胡热乎非人非非我 我二哥万人我国然而额外如果而我";
		byte titleSizes [] = str.getBytes();
		int subSize = titleSizes.length - titleSize;
		subSize = subSize + 3;
		int subLen = (((double)subSize/(double)3)>(subSize/3)?subSize/3+1:subSize/3);
		String shortTitle = str.substring(0,str.length()-subLen)+" "+"...";
		System.out.println(shortTitle);
	}

}
