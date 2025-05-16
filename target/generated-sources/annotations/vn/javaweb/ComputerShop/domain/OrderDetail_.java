package vn.javaweb.ComputerShop.domain;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(OrderDetail.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class OrderDetail_ {

	
	/**
	 * @see vn.javaweb.ComputerShop.domain.OrderDetail#product
	 **/
	public static volatile SingularAttribute<OrderDetail, Product> product;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.OrderDetail#quantity
	 **/
	public static volatile SingularAttribute<OrderDetail, Long> quantity;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.OrderDetail#price
	 **/
	public static volatile SingularAttribute<OrderDetail, Double> price;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.OrderDetail#id
	 **/
	public static volatile SingularAttribute<OrderDetail, Long> id;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.OrderDetail
	 **/
	public static volatile EntityType<OrderDetail> class_;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.OrderDetail#order
	 **/
	public static volatile SingularAttribute<OrderDetail, Order> order;

	public static final String PRODUCT = "product";
	public static final String QUANTITY = "quantity";
	public static final String PRICE = "price";
	public static final String ID = "id";
	public static final String ORDER = "order";

}

