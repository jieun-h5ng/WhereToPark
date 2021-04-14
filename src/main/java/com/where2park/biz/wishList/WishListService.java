package com.where2park.biz.wishList;

import java.util.List;

public interface WishListService {
	List<WishVO> getWishList(WishVO vo);
	void insertWish(WishVO vo);
	void deleteWish(WishVO vo);
}
