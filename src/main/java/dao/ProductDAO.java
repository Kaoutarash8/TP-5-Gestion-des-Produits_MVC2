package dao;

import model.Produit;
import java.util.List;

public interface ProductDAO {
    void save(Produit produit);
    List<Produit> findAll();
    Produit findById(int id);
    void delete(int id);
    void update(Produit produit);
}