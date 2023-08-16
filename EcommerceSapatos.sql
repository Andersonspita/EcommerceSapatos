-- Criação do Banco de Dados
CREATE DATABASE EcommerceSapatos;

-- Uso do Banco de Dados
USE EcommerceSapatos;

-- Criação da Tabela de Produtos
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    Tamanho VARCHAR(10),
    Categoria VARCHAR(50)
);

-- Criação da Tabela de Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Endereco VARCHAR(200),
	CPF VARCHAR(14),
	Celular VARCHAR(11)
);

-- Criação da Tabela de Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    DataPedido DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Criação da Tabela de Itens do Pedido
CREATE TABLE ItensPedido (
    ItemID INT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Inserção de Exemplo de Dados

-- Inserção de Produtos
INSERT INTO Produtos (ProdutoID, Nome, Descricao, Preco, Tamanho, Categoria)
VALUES
    (1, 'Tênis Esportivo', 'Tênis para atividades esportivas', 129.99, '42', 'Esportes'),
    (2, 'Sapato Social', 'Sapato elegante para ocasiões formais', 89.99, '40', 'Social'),
    (3, 'Sandália Casual', 'Sandália confortável para uso casual', 49.99, '38', 'Casual');

-- Inserção de Clientes
INSERT INTO Clientes (ClienteID, Nome, Email, Endereco, CPF, Celular)
VALUES
    (1, 'João Silva', 'joao@example.com', 'Rua das Flores, 123', '123.456.789-10', '71993570954'),
    (2, 'Maria Santos', 'maria@example.com', 'Av. Principal, 456', '032.446.719-15', '71991570156');

-- Inserção de Pedidos
INSERT INTO Pedidos (PedidoID, ClienteID, DataPedido, Total)
VALUES
    (1, 1, '2023-05-10', 179.98),
    (2, 2, '2023-05-11', 129.99);

-- Inserção de Itens do Pedido
INSERT INTO ItensPedido (ItemID, PedidoID, ProdutoID, Quantidade, Subtotal)
VALUES
    (1, 1, 1, 1, 129.99),
    (2, 1, 2, 1, 89.99),
    (3, 2, 3, 2, 99.98);

-- Exemplos de Queries

-- Selecionar todos os produtos
SELECT * FROM Produtos
WHERE Categoria = 'Casual';

-- Selecionar todos os clientes
SELECT * FROM Clientes;

-- Selecionar todos os pedidos com detalhes
SELECT P.PedidoID, C.Nome AS Cliente, P.DataPedido, P.Total,
       IP.Quantidade, PR.Nome AS Produto, PR.Preco
FROM Pedidos AS P
JOIN Clientes AS C ON P.ClienteID = C.ClienteID
JOIN ItensPedido AS IP ON P.PedidoID = IP.PedidoID
JOIN Produtos AS PR ON IP.ProdutoID = PR.ProdutoID;

-- Calcular o total de vendas por categoria
SELECT PR.Categoria, SUM(IP.Subtotal) AS TotalVendas
FROM Pedidos AS P
JOIN ItensPedido AS IP ON P.PedidoID = IP.PedidoID
JOIN Produtos AS PR ON IP.ProdutoID = PR.ProdutoID
GROUP BY PR.Categoria
HAVING SUM(IP.Subtotal) > 90;