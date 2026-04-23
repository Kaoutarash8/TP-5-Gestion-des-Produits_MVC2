package dao;

import model.User;  

public interface UserDAO {
    User findByUsername(String username);
    void save(User user);
}