package vn.javaweb.ComputerShop.repository.custom.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Repository;
import vn.javaweb.ComputerShop.domain.dto.request.ProductFilterDTO;
import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
import vn.javaweb.ComputerShop.domain.entity.ProductEntity;
import vn.javaweb.ComputerShop.repository.custom.ProductRepositoryCustom;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductRepositoryCustomImpl implements ProductRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(ProductFilterDTO productFilterDTO , StringBuilder sql){

    }

    public static void queryNormal(ProductFilterDTO productFilterDTO , StringBuilder sql){

        if (productFilterDTO.getFactory() != null && !productFilterDTO.getFactory().isEmpty()) {
            sql.append(" AND (");  // Mở ngoặc cho các điều kiện OR
            for (int i = 0; i < productFilterDTO.getFactory().size(); i++) {
                String factory = productFilterDTO.getFactory().get(i).trim();
                if (i > 0) {
                    sql.append(" OR "); // Chỉ thêm OR từ phần tử thứ 2 trở đi
                }
                sql.append("products.factory = '").append(factory).append("'");
            }
            sql.append(")");  // Đóng ngoặc sau khi kết thúc các điều kiện OR
        }
        if ( productFilterDTO.getTarget() != null && !productFilterDTO.getTarget().isEmpty()){
            sql.append(" AND (");
            for ( int i = 0 ; i <  productFilterDTO.getTarget().size() ; i++){
                String target = productFilterDTO.getTarget().get(i).trim();
                if ( i > 0){
                    sql.append(" OR ");
                }
                sql.append(" products.target = '").append(target).append("'");

            }
            sql.append(")");
        }


    }

    public static void queryPriceUnion(ProductFilterDTO productFilterDTO , StringBuilder sql){


        if (productFilterDTO.getPrice() != null && !productFilterDTO.getPrice().isEmpty() ){
            List<String> unionQuery = new ArrayList<>();
            for ( String price :  productFilterDTO.getPrice() ) {
                double min = 0;
                double max = 0;

                switch (price.trim()) {
                    case "duoi-10-trieu":
                        min = 0;
                        max = 10000000;
                        break;
                    case "10-15-trieu":
                        min = 10000000;
                        max = 15000000;
                        break;
                    case "15-20-trieu":
                        min = 15000000;
                        max = 20000000;
                        break;
                    case "tren-20-trieu":
                        min = 20000000;
                        max = 200000000;
                        break;
                }

                StringBuilder subSql = new StringBuilder();
                subSql.append("SELECT products.id, products.name, products.image, products.short_desc, products.price ")
                        .append("FROM products WHERE 1=1 ");
                queryNormal(productFilterDTO , subSql);

                subSql.append(" AND products.price >= ").append(min).append(" AND products.price < ").append(max);
                unionQuery.add(subSql.toString());
            }

            // ngoai vong lap
            sql.setLength(0); // reset sql gốc
            sql.append(String.join(" UNION ALL ", unionQuery));


            // boc all_results de sai order by trong truong hop co 2 sql


            // Có thể gắn tiếp ORDER BY nếu cần

        }
    }

    public static void querySpecial(ProductFilterDTO productFilterDTO , StringBuilder sql){
        String sortField = "price"; // Mặc định là 'price', vì dù là 'products.price' hay 'all_results.price' thì đều được alias đúng
        String sortTableAlias = sql.toString().contains("AS all_results") ? "all_results" : "products";

        if (productFilterDTO.getSort()!=null && !productFilterDTO.getSort().isEmpty()){
            switch (productFilterDTO.getSort().trim()){
                case "gia-tang-dan":
                    sql.append(" ORDER BY ").append(sortTableAlias).append(".").append(sortField).append(" ASC ");
                    break;
                case "gia-giam-dan":
                    sql.append(" ORDER BY ").append(sortTableAlias).append(".").append(sortField).append(" DESC ");
                    break;
            }

        }


    }
    public final String specialQuery (){

        return null;
    }


    @Override
    public Page<ProductRpDTO> findProductFilter(ProductFilterDTO productFilterDTO, Pageable pageable) {
        StringBuilder sql = new StringBuilder();
        boolean hasMultiplePriceRanges = productFilterDTO.getPrice() != null && productFilterDTO.getPrice().size() > 1;

        if (hasMultiplePriceRanges) {
            StringBuilder unionSql = new StringBuilder();
            queryPriceUnion(productFilterDTO, unionSql);
            sql = new StringBuilder("SELECT * FROM (").append(unionSql).append(") AS all_results");
            querySpecial(productFilterDTO, sql);
        } else {
            queryPriceUnion(productFilterDTO, sql);
            querySpecial(productFilterDTO, sql);
        }

        // neu ma ko co price thi cai ham queryPriceUnion() no se tra ve sql trong tuc la nguoi dung ko set price
        if (sql.isEmpty()) {
            sql.append("SELECT products.id, products.name, products.image, products.short_desc, products.price FROM products WHERE 1=1 ");
            queryNormal(productFilterDTO, sql);
            querySpecial(productFilterDTO, sql);
        }


        String querySql = sql.toString();
        Query query = entityManager.createNativeQuery( querySql , ProductRpDTO.class);

        // Đếm số bản ghi( row ) => so page
        List<Object> rows = query.getResultList();
        long totalResults = rows.size();

        // setup pagination cho List<BuildingEntity>
        query.setFirstResult((int) pageable.getOffset());
        query.setMaxResults(pageable.getPageSize());
        List<ProductRpDTO> resultList = query.getResultList();



        return new PageImpl<>(resultList, pageable , totalResults);
    }
}


//package vn.javaweb.ComputerShop.repository.custom.impl;
//
//import jakarta.persistence.EntityManager;
//import jakarta.persistence.PersistenceContext;
//import jakarta.persistence.Query;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageImpl;
//import org.springframework.data.domain.Pageable;
//import org.springframework.stereotype.Repository;
//import vn.javaweb.ComputerShop.domain.dto.request.ProductFilterDTO;
//import vn.javaweb.ComputerShop.domain.dto.response.ProductRpDTO;
//import vn.javaweb.ComputerShop.repository.custom.ProductRepositoryCustom;
//
//import java.util.ArrayList;
//import java.util.List;
//
//@Repository
//public class ProductRepositoryCustomImpl implements ProductRepositoryCustom {
//
//    @PersistenceContext
//    private EntityManager entityManager;
//
//    /**
//     * Build the SQL part for filters factory and target.
//     */
//    private void appendFactoryAndTargetFilter(ProductFilterDTO productFilterDTO, StringBuilder sql) {
//        if (productFilterDTO.getFactory() != null && !productFilterDTO.getFactory().isEmpty()) {
//            sql.append(" AND (");
//            for (int i = 0; i < productFilterDTO.getFactory().size(); i++) {
//                if (i > 0) sql.append(" OR ");
//                sql.append("products.factory = '").append(productFilterDTO.getFactory().get(i).trim()).append("'");
//            }
//            sql.append(") ");
//        }
//
//        if (productFilterDTO.getTarget() != null && !productFilterDTO.getTarget().isEmpty()) {
//            sql.append(" AND (");
//            for (int i = 0; i < productFilterDTO.getTarget().size(); i++) {
//                if (i > 0) sql.append(" OR ");
//                sql.append("products.target = '").append(productFilterDTO.getTarget().get(i).trim()).append("'");
//            }
//            sql.append(") ");
//        }
//    }
//
//    /**
//     * Build the SQL part for price filter with UNION ALL between price ranges.
//     * If no price filter, just return base query.
//     */
//    private String buildPriceUnionQuery(ProductFilterDTO productFilterDTO) {
//        if (productFilterDTO.getPrice() == null || productFilterDTO.getPrice().isEmpty()) {
//            // No price filter, return empty string to append no condition
//            return "";
//        }
//
//        List<String> selects = new ArrayList<>();
//        for (String priceRange : productFilterDTO.getPrice()) {
//            double min = 0;
//            double max = 0;
//
//            switch (priceRange) {
//                case "duoi-10-trieu":
//                    min = 0;
//                    max = 10000000;
//                    break;
//                case "10-15-trieu":
//                    min = 10000000;
//                    max = 15000000;
//                    break;
//                case "15-20-trieu":
//                    min = 15000000;
//                    max = 20000000;
//                    break;
//                case "tren-20-trieu":
//                    min = 20000000;
//                    max = 200000000;
//                    break;
//                default:
//                    continue; // skip invalid price ranges
//            }
//
//            // Build each SELECT with common filters except price condition
//            StringBuilder select = new StringBuilder();
//            select.append("SELECT products.id, products.name, products.image, products.short_desc, products.price FROM products WHERE 1=1 ");
//
//            // Factory filter
//            if (productFilterDTO.getFactory() != null && !productFilterDTO.getFactory().isEmpty()) {
//                select.append(" AND (");
//                for (int i = 0; i < productFilterDTO.getFactory().size(); i++) {
//                    if (i > 0) select.append(" OR ");
//                    select.append("products.factory = '").append(productFilterDTO.getFactory().get(i).trim()).append("'");
//                }
//                select.append(") ");
//            }
//
//            // Target filter
//            if (productFilterDTO.getTarget() != null && !productFilterDTO.getTarget().isEmpty()) {
//                select.append(" AND (");
//                for (int i = 0; i < productFilterDTO.getTarget().size(); i++) {
//                    if (i > 0) select.append(" OR ");
//                    select.append("products.target = '").append(productFilterDTO.getTarget().get(i).trim()).append("'");
//                }
//                select.append(") ");
//            }
//
//            // Price filter
//            select.append(" AND products.price >= ").append(min).append(" AND products.price < ").append(max);
//
//            selects.add(select.toString());
//        }
//
//        if (selects.isEmpty()) return "";
//
//        // Join all selects by UNION ALL
//        return String.join(" UNION ALL ", selects);
//    }
//
//    /**
//     * Append order by clause
//     */
//    private void appendOrderBy(ProductFilterDTO productFilterDTO, StringBuilder sql) {
//        if (productFilterDTO.getSort() != null && !productFilterDTO.getSort().isEmpty()) {
//            switch (productFilterDTO.getSort().trim()) {
//                case "gia-tang-dan":
//                    sql.append(" ORDER BY price ASC ");
//                    break;
//                case "gia-giam-dan":
//                    sql.append(" ORDER BY price DESC ");
//                    break;
//            }
//        }
//    }
//
//    @Override
//    public Page<ProductRpDTO> findProductFilter(ProductFilterDTO productFilterDTO, Pageable pageable) {
//        String sql;
//
//        if (productFilterDTO.getPrice() != null && !productFilterDTO.getPrice().isEmpty()) {
//            // Build query with UNION ALL for price filter
//            sql = buildPriceUnionQuery(productFilterDTO);
//        } else {
//            // Build single query without price condition
//            StringBuilder sqlBuilder = new StringBuilder("SELECT products.id, products.name, products.image, products.short_desc, products.price FROM products WHERE 1=1 ");
//            appendFactoryAndTargetFilter(productFilterDTO, sqlBuilder);
//            sql = sqlBuilder.toString();
//        }
//
//        // Wrap query to apply ORDER BY and pagination
//        StringBuilder finalSql = new StringBuilder("SELECT * FROM (").append(sql).append(") AS products_filtered ");
//
//        // Append order by
//        appendOrderBy(productFilterDTO, finalSql);
//
//        // Append pagination (limit, offset) for example with MySQL syntax
//        finalSql.append(" LIMIT ").append(pageable.getPageSize()).append(" OFFSET ").append(pageable.getOffset());
//
//        Query nativeQuery = entityManager.createNativeQuery(finalSql.toString(), ProductRpDTO.class);
//        // "ProductRpDTOMapping" phải được khai báo trong @SqlResultSetMapping hoặc bạn có thể tự map kết quả thủ công.
//
//        @SuppressWarnings("unchecked")
//        List<ProductRpDTO> resultList = nativeQuery.getResultList();
//
//        // Đếm tổng số bản ghi cho paging
//        String countSql = "SELECT COUNT(*) FROM products WHERE 1=1 ";
//        StringBuilder countBuilder = new StringBuilder(countSql);
//        appendFactoryAndTargetFilter(productFilterDTO, countBuilder);
//
//        if (productFilterDTO.getPrice() != null && !productFilterDTO.getPrice().isEmpty()) {
//            // Nếu có filter price thì phải tính count theo các khoảng giá (có thể phức tạp hơn)
//            // Ở đây tạm tính count đơn giản không chính xác cho ví dụ
//        }
//
//        Query countQuery = entityManager.createNativeQuery(countBuilder.toString());
//        Number total = ((Number) countQuery.getSingleResult());
//
//        return new PageImpl<>(resultList, pageable, total.longValue());
//    }
//}
