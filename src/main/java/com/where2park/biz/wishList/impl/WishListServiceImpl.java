package com.where2park.biz.wishList.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.where2park.biz.wishList.WishListService;
import com.where2park.biz.wishList.WishVO;

@Service("WishListService")
public class WishListServiceImpl implements WishListService {
	
	@Autowired
	private WishListDAOMybatis wishListDAO;
	
	@Autowired
	HttpSession session;

	@Override
	public List<WishVO> getWishList(WishVO vo) {
		System.out.println(wishListDAO.getWishList(vo)+"Wish list Service impl get wish list");
		return wishListDAO.getWishList(vo);
	}

	@Override
	public void insertWish(WishVO vo) {
		System.out.println("Wish list Service impl insert wish list");
		wishListDAO.insertWish(vo);
	}

	@Override
	public void deleteWish(WishVO vo) {
		System.out.println("Wish list Service impl delete wish list");
		wishListDAO.deleteWish(vo);
	}

}
