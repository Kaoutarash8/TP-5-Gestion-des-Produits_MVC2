package services;

import model.Produit;
import java.util.List;

public interface ProductService {
    void addProduct(Produit product);
    void updateProduct(Produit product);
    void deleteProduct(int id);
    Produit getProductById(int id);
    List<Produit> getAllProducts();
}