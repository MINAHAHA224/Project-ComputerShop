package vn.javaweb.ComputerShop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import vn.javaweb.ComputerShop.domain.entity.ProductEntity;

@Repository

public interface ProductRepository extends JpaRepository<ProductEntity, Long>, JpaSpecificationExecutor<ProductEntity> {

   ProductEntity save(ProductEntity hoidanit);

   List<ProductEntity> findFirstById(long id);

   ProductEntity findById(long id);

   void deleteById(long id);

   Page<ProductEntity> findAll(Pageable page);

   Page<ProductEntity> findAll(Specification<ProductEntity> spec, Pageable pageable);

}