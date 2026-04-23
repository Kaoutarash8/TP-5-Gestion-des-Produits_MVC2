<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-white">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                
                <h3 class="text-center text-primary mb-4">Connexion</h3>
                
                <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-primary text-center">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                
                <form method="post" action="login.do">
                    <input type="text" name="username" class="form-control mb-3" placeholder="Nom d'utilisateur" required>
                    <input type="password" name="password" class="form-control mb-3" placeholder="Mot de passe" required>
                    <button type="submit" class="btn btn-primary w-100">Se connecter</button>
                </form>
                
                
            </div>
        </div>
    </div>

</body>
</html>