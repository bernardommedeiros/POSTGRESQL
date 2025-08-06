INSERT INTO Grupo (nome, descricao, icone_url, banner_url, codigo, aprovacao_necessaria
) VALUES 
	('Grupo Postgre', 'Grupo Banco de dados', 'https://bd.com/icone.png',
	'https://bd.com/banner.png','12345', TRUE),
	('BRAINZ', 'Competição saudável entre amigos', 'https://brainzicon.com/icone.png',
	'https://brainzlogo.com/banner.png','ABCDEF', FALSE);

INSERT INTO Competicao (id_grupo, titulo, descricao, ativa, data_inicio, data_fim, finalizada_em) 
VALUES 
(
    1,
    'Desafio SQL',
    'Estudar banco de dados relacional',
    TRUE,
    CURRENT_TIMESTAMP,
    '2025-08-31 23:59:59',
    NULL
),
(
    2,
    'Django diário',
    'Competição de dsweb diariamente',
    TRUE,
    CURRENT_TIMESTAMP,
    '2026-09-11 23:59:59',
    NULL
);

INSERT INTO Missao (id_competicao, titulo, descricao, points)
VALUES 
(
    1,
    'Praticar SQL',
    'Criar tabelas e inserir dados usando SQL.',
    10
),

(
    2,
    'Implementar autenticação django',
    'Sistema de autenticação simples usando Django.',
    20
);