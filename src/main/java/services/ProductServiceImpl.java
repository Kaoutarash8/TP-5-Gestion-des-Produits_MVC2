package services;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import model.Produit;
import java.util.List;

public class ProductServiceImpl implements ProductService {
    
    private ProductDAO productDAO = new ProductDAOImpl();
    
    @Override
    public void addProduct(Produit product) {
        productDAO.save(product);
    }
    
    @Override
    public void updateProduct(Produit product) {
        productDAO.update(product);
    }
    
    @Override
    public void deleteProduct(int id) {
        productDAO.delete(id);
    }
    
    @Override
    public Produit getProductById(int id) {
        return productDAO.findById(id);
    }
    
    @Override
    public List<Produit> getAllProducts() {
        return productDAO.findAll();
    }
}