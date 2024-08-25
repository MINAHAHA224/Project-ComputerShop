package vn.javaweb.ComputerShop.domain.dto;

import java.util.List;
import java.util.Optional;

public class ProductCriteriaDTO {
    private Optional<String> page;
    private Optional<List<String>> factory;
    private Optional<List<String>> target;
    private Optional<List<String>> price;
    private Optional<String> sort;

    public void setPage(Optional<String> page) {
        this.page = page;
    }

    public void setFactory(Optional<List<String>> factory) {
        this.factory = factory;
    }

    public void setTarget(Optional<List<String>> target) {
        this.target = target;
    }

    public void setPrice(Optional<List<String>> price) {
        this.price = price;
    }

    public void setSort(Optional<String> sort) {
        this.sort = sort;
    }

    public Optional<String> getPage() {
        return page;
    }

    public Optional<List<String>> getFactory() {
        return factory;
    }

    public Optional<List<String>> getTarget() {
        return target;
    }

    public Optional<List<String>> getPrice() {
        return price;
    }

    public Optional<String> getSort() {
        return sort;
    }

}
