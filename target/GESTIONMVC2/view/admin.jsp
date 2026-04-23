<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Produits</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f5f5;
        }
        .header {
            background: #0066cc;
            color: white;
            padding: 15px 20px;
            margin-bottom: 20px;
        }
        .header a {
            color: white;
            text-decoration: none;
            float: right;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background: #0066cc;
            color: white;
        }
        .btn {
            display: inline-block;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 3px;
            cursor: pointer;
            border: none;
        }
        .btn-primary {
            background: #0066cc;
            color: white;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
        }
        .modal-content {
            background: white;
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="header">
        <span>Gestion des Produits</span>
        <span style="float:right">
            ${sessionScope.user} | <a href="logout.do">Deconnexion</a>
        </span>
    </div>
    
    <div class="container">
        <button class="btn btn-primary" onclick="openAddModal()">Ajouter</button>
        <br><br>
        
        <table>
            <thead>
                <tr><th>ID</th><th>Nom</th><th>Prix</th><th>Quantite</th><th>Actions</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${products}" var="p">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.nom}</td>
                        <td>${p.prix}</td>
                        <td>${p.quantite}</td>
                        <td>
                            <button class="btn btn-primary" onclick="openEditModal(${p.id}, '${p.nom}', ${p.prix}, ${p.quantite})">Modifier</button>
                            <button class="btn btn-danger" onclick="confirmDelete(${p.id})">Supprimer</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <!-- Modal Ajouter -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <h3>Ajouter</h3>
            <form action="addProduct.do" method="post">
                <div class="form-group">
                    <label>Nom:</label>
                    <input type="text" name="nom" required>
                </div>
                <div class="form-group">
                    <label>Prix:</label>
                    <input type="number" step="0.01" name="prix" required>
                </div>
                <div class="form-group">
                    <label>Quantite:</label>
                    <input type="number" name="quantite" required>
                </div>
                <button type="submit" class="btn btn-primary">Ajouter</button>
                <button type="button" class="btn btn-secondary" onclick="closeAddModal()">Annuler</button>
            </form>
        </div>
    </div>
    
    <!-- Modal Modifier -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <h3>Modifier</h3>
            <form action="editProduct.do" method="post">
                <input type="hidden" name="id" id="editId">
                <div class="form-group">
                    <label>Nom:</label>
                    <input type="text" name="nom" id="editNom" required>
                </div>
                <div class="form-group">
                    <label>Prix:</label>
                    <input type="number" step="0.01" name="prix" id="editPrix" required>
                </div>
                <div class="form-group">
                    <label>Quantite:</label>
                    <input type="number" name="quantite" id="editQuantite" required>
                </div>
                <button type="submit" class="btn btn-primary">Modifier</button>
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Annuler</button>
            </form>
        </div>
    </div>
    
    <script>
        function openAddModal() {
            document.getElementById('addModal').style.display = 'block';
        }
        function closeAddModal() {
            document.getElementById('addModal').style.display = 'none';
        }
        function openEditModal(id, nom, prix, quantite) {
            document.getElementById('editId').value = id;
            document.getElementById('editNom').value = nom;
            document.getElementById('editPrix').value = prix;
            document.getElementById('editQuantite').value = quantite;
            document.getElementById('editModal').style.display = 'block';
        }
        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }
        function confirmDelete(id) {
            if(confirm('Supprimer ce produit ?')) {
                window.location.href = 'deleteProduct.do?id=' + id;
            }
        }
    </script>
</body>
</html>