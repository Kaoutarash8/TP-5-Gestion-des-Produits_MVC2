<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body { font-family: Arial; margin: 50px; }
        .container { width: 300px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        input { width: 100%; padding: 8px; margin: 5px 0; }
        button { width: 100%; padding: 10px; background: #007bff; color: white; border: none; cursor: pointer; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Connexion</h2>
        <% if(request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <form method="post" action="login.do">
            <input type="text" name="username" placeholder="Nom d'utilisateur" required><br>
            <input type="password" name="password" placeholder="Mot de passe" required><br>
            <button type="submit">Se connecter</button>
        </form>
        <p style="margin-top: 20px; font-size: 12px;">Test: admin/admin ou user/user</p>
    </div>
</body>
</html>