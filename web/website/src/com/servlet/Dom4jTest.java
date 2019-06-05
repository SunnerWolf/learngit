package com.servlet;

import java.util.List;

import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class Dom4jTest {

	public static void main(String[] args) {
		
		SAXReader sax = new SAXReader();
		try {
			org.dom4j.Document doc = sax.read("D:\\Config.XML");
			Element element = doc.getRootElement();
			element.attribute("");
			
			List list = element.selectNodes("/reportenv/@");
			for (int i = 0; i < list.size(); i++) {
				
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		
	}
}
