-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS EmpresaVendas;
USE EmpresaVendas;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Telefone VARCHAR(15),
    Endereco TEXT
);

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS Produtos (
    ProdutoID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Estoque INT NOT NULL
);

-- Tabela de Vendas
CREATE TABLE IF NOT EXISTS Vendas (
    VendaID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    ProdutoID INT,
    Quantidade INT NOT NULL,
    DataVenda DATE NOT NULL,
    ValorTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Criar um usuário com acesso mínimo necessário
CREATE USER 'usuario_vendas'@'localhost' IDENTIFIED BY 'senha_segura';
GRANT SELECT, INSERT, UPDATE, DELETE ON EmpresaVendas.* TO 'usuario_vendas'@'localhost';
FLUSH PRIVILEGES;
