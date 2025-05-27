package vn.javaweb.ComputerShop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.repository.custom.ProductRepositoryCustom;

@Repository

public interface ProductRepository extends JpaRepository<ProductEntity, Long>, ProductRepositoryCustom {

   void deleteProductEntityById ( Long id);


   boolean existsProductEntityByName ( String name);






   ProductEntity findProductEntityById(long id);


   Page<ProductEntity> findAll(Pageable page);


}