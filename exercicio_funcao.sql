-- Criar o banco de dados
CREATE DATABASE TriggerDB;
USE TriggerDB;

-- Criar tabela "Clientes"
CREATE TABLE IF NOT EXISTS Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100)
);

-- Criar tabela "Pedidos"
CREATE TABLE IF NOT EXISTS Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    Produto VARCHAR(100),
    Quantidade INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Exemplo de Trigger: Atualizar total do pedido quando a quantidade é alterada
DELIMITER //
CREATE TRIGGER updateTotal
BEFORE UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    SET NEW.Total = NEW.Quantidade * 10.00; -- Supondo um preço fixo de 10.00 por item
END;
//
DELIMITER ;

-- Exemplo de Trigger: Impedir exclusão de cliente se houver pedidos associados
DELIMITER //
CREATE TRIGGER preventDeleteCliente
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    DECLARE pedidosCount INT;
    SELECT COUNT(*) INTO pedidosCount FROM Pedidos WHERE ClienteID = OLD.ClienteID;
    IF pedidosCount > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir o cliente, pois existem pedidos associados.';
    END IF;
END;
//
DELIMITER ;

-- Exemplo de Trigger: Logar inserção de novos pedidos
DELIMITER //
CREATE TRIGGER logInsertPedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO LogPedidos (Acao, Detalhes) VALUES ('INSERT', CONCAT('Novo pedido inserido - PedidoID: ', NEW.PedidoID));
END;
//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE LevantamentoDiario()
BEGIN
    SELECT
        data_compra,
        COUNT(*) as quantidade_comprada
    FROM
        vendas
    GROUP BY
        data_compra;
END //

DELIMITER ;LevantamentoDiario

-- Criação da Função
DELIMITER //
CREATE FUNCTION contarClientesPorDia(dataCadastro DATE) RETURNS INT
BEGIN
    DECLARE totalClientes INT;

    -- Realiza a contagem de clientes cadastrados na data específica
    SELECT COUNT(*) INTO totalClientes
    FROM tabela_clientes
    WHERE DATE(data_cadastro) = dataCadastro;

    RETURN totalClientes;
END //
DELIMITER ;

-- Exemplo de Uso da Função
-- Suponha que a data desejada seja '2023-11-01'
SELECT contarClientesPorDia('2023-11-01') AS TotalClientes;

