package vn.javaweb.ComputerShop.domain.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.ListAttribute;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(CartEntity.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class CartEntity_ {

	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.CartEntity#sum
	 **/
	public static volatile SingularAttribute<CartEntity, Integer> sum;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.CartEntity#cartDetails
	 **/
	public static volatile ListAttribute<CartEntity, CartDetailEntity> cartDetails;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.CartEntity#id
	 **/
	public static volatile SingularAttribute<CartEntity, Long> id;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.CartEntity
	 **/
	public static volatile EntityType<CartEntity> class_;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.CartEntity#user
	 **/
	public static volatile SingularAttribute<CartEntity, UserEntity> user;

	public static final String SUM = "sum";
	public static final String CART_DETAILS = "cartDetails";
	public static final String ID = "id";
	public static final String USER = "user";

}

