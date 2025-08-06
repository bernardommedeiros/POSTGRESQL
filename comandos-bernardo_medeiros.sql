-- Tabelas = Missão, Competição, Grupo
-- Todo o projeto foi desenvolvido no PgAdmin, com base no sgbd PostgreSQL.

-- Tarefa a - Criação das tabelas, setando o nome das tabelas, suas colunas e suas respectivas chaves primárias e estrangeiras
CREATE TABLE Grupo (
    id SERIAL NOT NULL,
    nome VARCHAR(64) NOT NULL,
    descricao TEXT,
    icone_url VARCHAR(255),
    banner_url VARCHAR(255),
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codigo VARCHAR(8) UNIQUE NULL,
    aprovacao_necessaria BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_grupo PRIMARY KEY (id)
);

CREATE TABLE Competicao (
    id SERIAL NOT NULL,
	id_grupo INT NOT NULL,
    titulo VARCHAR(64) NOT NULL,
    descricao TEXT,
    ativa BOOLEAN NOT NULL DEFAULT TRUE,
    data_inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_fim TIMESTAMP NOT NULL,
    finalizada_em TIMESTAMP,

    CONSTRAINT pk_competicao PRIMARY KEY (id),
	CONSTRAINT competicao_grupo_fk FOREIGN KEY (id_grupo) REFERENCES Grupo(id)
);

CREATE TABLE Missao (
    id SERIAL NOT NULL,
	id_competicao INT NOT NULL,
    titulo VARCHAR(32) NOT NULL,
    descricao TEXT,
    points INT NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_missao PRIMARY KEY (id),
    CONSTRAINT missao_competicao_fk FOREIGN KEY (id_competicao) REFERENCES Competicao(id)
);

-- Tarefa b - Inserção de dados nas tabelas, inserido dois valores em cada coluna
INSERT INTO Grupo (nome, descricao, icone_url, banner_url, codigo, aprovacao_necessaria
) VALUES 
	('Grupo Postgre', 'Grupo Banco de dados', 'https://bd.com/icone.png',
	'https://bd.com/banner.png','12345', TRUE),
	('BRAINZ', 'Competição saudável entre amigos', 'https://brainzicon.com/icone.png',
	'https://brainzlogo.com/banner.png','ABCDEF', FALSE);

INSERT INTO Competicao (id_grupo, titulo, descricao, ativa, data_inicio, data_fim, finalizada_em) 
VALUES 
(1, 'Desafio SQL', 'Estudar banco de dados relacional', TRUE, CURRENT_TIMESTAMP, '2025-08-31 23:59:59', NULL),
(2, 'Django diário', 'Competição de dsweb diariamente', TRUE, CURRENT_TIMESTAMP, '2026-09-11 23:59:59', NULL);

INSERT INTO Missao (id_competicao, titulo, descricao, points)
VALUES 
(1, 'Praticar SQL', 'Criar tabelas e inserir dados usando SQL.', 10),

(2, 'Implementar autenticação django', 'Sistema de autenticação simples usando Django.', 20);

-- Tarefa c - Atualização de dados de um registro com condição simples
UPDATE Missao
	SET titulo = 'Prova 2 bimestre'
	WHERE titulo = 'Praticar SQL';

-- Tarefa d - Atualização de dados de um registro com condição composta
UPDATE Grupo
    SET nome = 'Grupo de estudos sgbd'
    WHERE nome = 'Grupo Postgre' AND codigo = '12345';

-- Tarefa e - Atualização de dados de dois registros com condição simples
UPDATE Competicao
	SET descricao = 'prova final dsweb', titulo = 'Avaliação'
	WHERE id = 2;

-- Tarefa e - Atualização de dados de dois registros com condição composta
UPDATE Missao
    SET titulo = 'Prova final - projeto Django', points = 100
    WHERE id_competicao = 2 AND id = 2;

-- Tarefa f - Exclusão de dados de um registro com condição simples
DELETE FROM Missao
    WHERE titulo = 'Prova 2 bimestre';

-- Tarefa g - Exclusão de dados de um registro com condição composta
DELETE FROM Competicao
    WHERE id = 1 AND ativa = TRUE;

-- Tarefa h - Exclusão de dados que satisfazem uma condição que envolve uma coluna de outra tabela
DELETE FROM Grupo
    WHERE id NOT IN (SELECT id_grupo FROM Competicao);

-- Tarefa i - Exibição de dados que satisfazem uma condição simples
SELECT * FROM Missao
    WHERE points > 50;

-- Tarefa j - Exibição de dados que satisfazem uma condição composta
SELECT * FROM Competicao
    WHERE ativa = TRUE AND finalizada_em IS NULL;

-- Tarefa k - Exibição de dados de duas tabelas, usando operadores de junção qualificada
SELECT g.nome, c.titulo FROM Competicao AS c
INNER JOIN Grupo as g ON g.id = c.id_grupo;

-- Tarefa l - Exibição de dados de três tabelas, usando operadores de junção qualificada
SELECT g.nome, c.titulo, m.titulo, m.points FROM Competicao AS c
INNER JOIN Grupo AS g ON g.id = c.id_grupo
INNER JOIN Missao AS m ON m.id_competicao = c.id;

-- tarefa m - Exibição de dados de duas tabelas, usando operadores de junção externa.
SELECT g.nome, c.titulo FROM Grupo AS g
LEFT OUTER JOIN Competicao AS c ON g.id = c.id_grupo;

-- Tarefa n - Exibição de dados de tabelas, usando o operador FULL OUTER JOIN.
SELECT c.titulo AS competicao_titulo, c.descricao AS descricao_competicao, 
m.titulo AS titulo_missao, m.descricao AS missao_descricao, m.points AS pontos
FROM Missao AS m
FULL OUTER JOIN Competicao AS c ON m.id_competicao = c.id;