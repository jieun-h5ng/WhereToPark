package com.where2park.biz.wishList.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.where2park.biz.wishList.WishVO;

@Repository("wishListDAO")
public class WishListDAOMybatis {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<WishVO> getWishList(WishVO vo){
		System.out.println("⇒ Mybatis로 getWishList 기능");
		return mybatis.selectList("WishListDAO.getWishList", vo);
	}
	
	public void insertWish(WishVO vo) {
		System.out.println("⇒ Mybatis로 insertWish 기능");
		mybatis.insert("WishListDAO.insertWish", vo);
	}
	
	public void deleteWish(WishVO vo) {
		System.out.println("⇒ Mybatis로 deleteWish 기능");
		mybatis.delete("WishListDAO.deleteWish", vo);
	}
}
