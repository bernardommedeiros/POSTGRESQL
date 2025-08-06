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