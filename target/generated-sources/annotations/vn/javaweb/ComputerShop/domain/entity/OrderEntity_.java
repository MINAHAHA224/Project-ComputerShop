package vn.javaweb.ComputerShop.domain.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.ListAttribute;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(OrderEntity.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class OrderEntity_ {

	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#receiverAddress
	 **/
	public static volatile SingularAttribute<OrderEntity, String> receiverAddress;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#orderDetails
	 **/
	public static volatile ListAttribute<OrderEntity, OrderDetailEntity> orderDetails;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#receiverPhone
	 **/
	public static volatile SingularAttribute<OrderEntity, String> receiverPhone;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#totalPrice
	 **/
	public static volatile SingularAttribute<OrderEntity, Double> totalPrice;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#receiverName
	 **/
	public static volatile SingularAttribute<OrderEntity, String> receiverName;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#id
	 **/
	public static volatile SingularAttribute<OrderEntity, Long> id;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity
	 **/
	public static volatile EntityType<OrderEntity> class_;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#user
	 **/
	public static volatile SingularAttribute<OrderEntity, UserEntity> user;
	
	/**
	 * @see vn.javaweb.ComputerShop.domain.entity.OrderEntity#status
	 **/
	public static volatile SingularAttribute<OrderEntity, String> status;

	public static final String RECEIVER_ADDRESS = "receiverAddress";
	public static final String ORDER_DETAILS = "orderDetails";
	public static final String RECEIVER_PHONE = "receiverPhone";
	public static final String TOTAL_PRICE = "totalPrice";
	public static final String RECEIVER_NAME = "receiverName";
	public static final String ID = "id";
	public static final String USER = "user";
	public static final String STATUS = "status";

}

