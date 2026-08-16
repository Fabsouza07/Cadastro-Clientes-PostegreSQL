-- Execute este arquivo conectado ao banco cadastro_clientes.

CREATE TABLE IF NOT EXISTS clientes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    idade INTEGER NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    email VARCHAR(160) NOT NULL UNIQUE,
    telefone_fixo VARCHAR(20),
    telefone_celular VARCHAR(20)
);

ALTER TABLE clientes ADD COLUMN IF NOT EXISTS telefone_fixo VARCHAR(20);
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS telefone_celular VARCHAR(20);

CREATE TABLE IF NOT EXISTS usuarios_cadastro_clientes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login VARCHAR(50) NOT NULL UNIQUE,
    senha_hash BYTEA NOT NULL,
    senha_salt BYTEA NOT NULL,
    administrador BOOLEAN NOT NULL DEFAULT FALSE,
    criado_em TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tentativas_falhas INTEGER NOT NULL DEFAULT 0,
    bloqueado_ate TIMESTAMP WITH TIME ZONE
);

ALTER TABLE usuarios_cadastro_clientes
    ADD COLUMN IF NOT EXISTS tentativas_falhas INTEGER NOT NULL DEFAULT 0;
ALTER TABLE usuarios_cadastro_clientes
    ADD COLUMN IF NOT EXISTS bloqueado_ate TIMESTAMP WITH TIME ZONE;

-- Padroniza telefones existentes no formato brasileiro usado pelo cadastro.
WITH telefones AS (
    SELECT
        id,
        regexp_replace(coalesce(telefone_fixo, ''), '\D', '', 'g') AS fixo,
        regexp_replace(coalesce(telefone_celular, ''), '\D', '', 'g') AS celular
    FROM clientes
)
UPDATE clientes AS cliente
SET
    telefone_fixo = CASE
        WHEN length(fixo) = 10
            THEN regexp_replace(fixo, '^(\d{2})(\d{4})(\d{4})$', '(\1) \2-\3')
        ELSE cliente.telefone_fixo
    END,
    telefone_celular = CASE
        WHEN length(celular) = 11
            THEN regexp_replace(celular, '^(\d{2})(\d{5})(\d{4})$', '(\1) \2-\3')
        ELSE cliente.telefone_celular
    END
FROM telefones
WHERE telefones.id = cliente.id;
