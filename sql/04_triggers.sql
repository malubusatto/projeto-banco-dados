-- TABELA USUARIO_LOG
CREATE TABLE USUARIO_LOG (
    ID_LOG NUMBER NOT NULL,
    ID_USUARIO NUMBER,
    OPERACAO VARCHAR2(10),
    DATA_OPERACAO TIMESTAMP,
    USUARIO_BANCO VARCHAR2(100),

    NOME_ANTIGO VARCHAR2(100),
    NOME_NOVO VARCHAR2(100),

    EMAIL_ANTIGO VARCHAR2(150),
    EMAIL_NOVO VARCHAR2(150)
);

-- TABELA CLIENTE_LOG
CREATE TABLE CLIENTE_LOG (
    ID_LOG NUMBER NOT NULL,
    ID_CLIENTE NUMBER,
    OPERACAO VARCHAR2(10),
    DATA_OPERACAO TIMESTAMP,
    USUARIO_BANCO VARCHAR2(100),

    ID_USUARIO_ANTIGO NUMBER,
    ID_USUARIO_NOVO NUMBER
);

-- TABELA PRODUTO_LOG
CREATE TABLE PRODUTO_LOG (
    ID_LOG NUMBER NOT NULL,
    ID_PRODUTO NUMBER,
    OPERACAO VARCHAR2(10),
    DATA_OPERACAO TIMESTAMP,
    USUARIO_BANCO VARCHAR2(100),

    NOME_ANTIGO VARCHAR2(150),
    NOME_NOVO VARCHAR2(150),

    PRECO_ANTIGO NUMBER(10,2),
    PRECO_NOVO NUMBER(10,2)
);

-- TABELA PEDIDO_LOG
CREATE TABLE PEDIDO_LOG (
    ID_LOG NUMBER NOT NULL,
    ID_PEDIDO NUMBER,
    OPERACAO VARCHAR2(10),
    DATA_OPERACAO TIMESTAMP,
    USUARIO_BANCO VARCHAR2(100),

    STATUS_ANTIGO NUMBER,
    STATUS_NOVO NUMBER
);

-- TABELA PAGAMENTO_LOG
CREATE TABLE PAGAMENTO_LOG (
    ID_LOG NUMBER NOT NULL,
    ID_PAGAMENTO NUMBER,
    OPERACAO VARCHAR2(10),
    DATA_OPERACAO TIMESTAMP,
    USUARIO_BANCO VARCHAR2(100),

    VALOR_ANTIGO NUMBER(10,2),
    VALOR_NOVO NUMBER(10,2)
);

-- SEQUENCES
CREATE SEQUENCE SEQ_USUARIO_LOG START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_CLIENTE_LOG START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PRODUTO_LOG START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PEDIDO_LOG START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PAGAMENTO_LOG START WITH 1 INCREMENT BY 1 NOCACHE;

-- TRIGGERS
CREATE OR REPLACE TRIGGER TRG_LOG_USUARIO
AFTER INSERT OR UPDATE OR DELETE
ON USUARIO
FOR EACH ROW
BEGIN

    IF INSERTING THEN

        INSERT INTO USUARIO_LOG (
            ID_LOG,
            ID_USUARIO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            NOME_NOVO,
            EMAIL_NOVO
        )
        VALUES (
            SEQ_USUARIO_LOG.NEXTVAL,
            :NEW.ID_USUARIO,
            'INSERT',
            SYSTIMESTAMP,
            USER,
            :NEW.NOME,
            :NEW.EMAIL
        );

    ELSIF UPDATING THEN

        INSERT INTO USUARIO_LOG (
            ID_LOG,
            ID_USUARIO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            NOME_ANTIGO,
            NOME_NOVO,
            EMAIL_ANTIGO,
            EMAIL_NOVO
        )
        VALUES (
            SEQ_USUARIO_LOG.NEXTVAL,
            :NEW.ID_USUARIO,
            'UPDATE',
            SYSTIMESTAMP,
            USER,
            :OLD.NOME,
            :NEW.NOME,
            :OLD.EMAIL,
            :NEW.EMAIL
        );

    ELSIF DELETING THEN

        INSERT INTO USUARIO_LOG (
            ID_LOG,
            ID_USUARIO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            NOME_ANTIGO,
            EMAIL_ANTIGO
        )
        VALUES (
            SEQ_USUARIO_LOG.NEXTVAL,
            :OLD.ID_USUARIO,
            'DELETE',
            SYSTIMESTAMP,
            USER,
            :OLD.NOME,
            :OLD.EMAIL
        );

    END IF;

END;
/
    
CREATE OR REPLACE TRIGGER TRG_LOG_CLIENTE
AFTER INSERT OR UPDATE OR DELETE
ON CLIENTE
FOR EACH ROW
BEGIN

    IF INSERTING THEN

        INSERT INTO CLIENTE_LOG (
            ID_LOG,
            ID_CLIENTE,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            ID_USUARIO_NOVO
        )
        VALUES (
            SEQ_CLIENTE_LOG.NEXTVAL,
            :NEW.ID_CLIENTE,
            'INSERT',
            SYSTIMESTAMP,
            USER,
            :NEW.ID_USUARIO
        );

    ELSIF UPDATING THEN

        INSERT INTO CLIENTE_LOG (
            ID_LOG,
            ID_CLIENTE,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            ID_USUARIO_ANTIGO,
            ID_USUARIO_NOVO
        )
        VALUES (
            SEQ_CLIENTE_LOG.NEXTVAL,
            :NEW.ID_CLIENTE,
            'UPDATE',
            SYSTIMESTAMP,
            USER,
            :OLD.ID_USUARIO,
            :NEW.ID_USUARIO
        );

    ELSIF DELETING THEN

        INSERT INTO CLIENTE_LOG (
            ID_LOG,
            ID_CLIENTE,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            ID_USUARIO_ANTIGO
        )
        VALUES (
            SEQ_CLIENTE_LOG.NEXTVAL,
            :OLD.ID_CLIENTE,
            'DELETE',
            SYSTIMESTAMP,
            USER,
            :OLD.ID_USUARIO
        );

    END IF;

END;
/

CREATE OR REPLACE TRIGGER TRG_LOG_PRODUTO
AFTER INSERT OR UPDATE OR DELETE
ON PRODUTO
FOR EACH ROW
BEGIN

    IF INSERTING THEN

        INSERT INTO PRODUTO_LOG (
            ID_LOG,
            ID_PRODUTO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            NOME_NOVO,
            PRECO_NOVO
        )
        VALUES (
            SEQ_PRODUTO_LOG.NEXTVAL,
            :NEW.ID_PRODUTO,
            'INSERT',
            SYSTIMESTAMP,
            USER,
            :NEW.NOME,
            :NEW.PRECO
        );

    ELSIF UPDATING THEN

        INSERT INTO PRODUTO_LOG (
            ID_LOG,
            ID_PRODUTO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            NOME_ANTIGO,
            NOME_NOVO,
            PRECO_ANTIGO,
            PRECO_NOVO
        )
        VALUES (
            SEQ_PRODUTO_LOG.NEXTVAL,
            :NEW.ID_PRODUTO,
            'UPDATE',
            SYSTIMESTAMP,
            USER,
            :OLD.NOME,
            :NEW.NOME,
            :OLD.PRECO,
            :NEW.PRECO
        );

    ELSIF DELETING THEN

        INSERT INTO PRODUTO_LOG (
            ID_LOG,
            ID_PRODUTO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            NOME_ANTIGO,
            PRECO_ANTIGO
        )
        VALUES (
            SEQ_PRODUTO_LOG.NEXTVAL,
            :OLD.ID_PRODUTO,
            'DELETE',
            SYSTIMESTAMP,
            USER,
            :OLD.NOME,
            :OLD.PRECO
        );

    END IF;

END;
/

CREATE OR REPLACE TRIGGER TRG_LOG_PEDIDO
AFTER INSERT OR UPDATE OR DELETE
ON PEDIDO
FOR EACH ROW
BEGIN

    IF INSERTING THEN

        INSERT INTO PEDIDO_LOG (
            ID_LOG,
            ID_PEDIDO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            STATUS_NOVO
        )
        VALUES (
            SEQ_PEDIDO_LOG.NEXTVAL,
            :NEW.ID_PEDIDO,
            'INSERT',
            SYSTIMESTAMP,
            USER,
            :NEW.ID_STATUS
        );

    ELSIF UPDATING THEN

        INSERT INTO PEDIDO_LOG (
            ID_LOG,
            ID_PEDIDO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            STATUS_ANTIGO,
            STATUS_NOVO
        )
        VALUES (
            SEQ_PEDIDO_LOG.NEXTVAL,
            :NEW.ID_PEDIDO,
            'UPDATE',
            SYSTIMESTAMP,
            USER,
            :OLD.ID_STATUS,
            :NEW.ID_STATUS
        );

    ELSIF DELETING THEN

        INSERT INTO PEDIDO_LOG (
            ID_LOG,
            ID_PEDIDO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            STATUS_ANTIGO
        )
        VALUES (
            SEQ_PEDIDO_LOG.NEXTVAL,
            :OLD.ID_PEDIDO,
            'DELETE',
            SYSTIMESTAMP,
            USER,
            :OLD.ID_STATUS
        );

    END IF;

END;
/

CREATE OR REPLACE TRIGGER TRG_LOG_PAGAMENTO
AFTER INSERT OR UPDATE OR DELETE
ON PAGAMENTO
FOR EACH ROW
BEGIN

    IF INSERTING THEN

        INSERT INTO PAGAMENTO_LOG (
            ID_LOG,
            ID_PAGAMENTO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            VALOR_NOVO
        )
        VALUES (
            SEQ_PAGAMENTO_LOG.NEXTVAL,
            :NEW.ID_PAGAMENTO,
            'INSERT',
            SYSTIMESTAMP,
            USER,
            :NEW.VALOR
        );

    ELSIF UPDATING THEN

        INSERT INTO PAGAMENTO_LOG (
            ID_LOG,
            ID_PAGAMENTO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            VALOR_ANTIGO,
            VALOR_NOVO
        )
        VALUES (
            SEQ_PAGAMENTO_LOG.NEXTVAL,
            :NEW.ID_PAGAMENTO,
            'UPDATE',
            SYSTIMESTAMP,
            USER,
            :OLD.VALOR,
            :NEW.VALOR
        );

    ELSIF DELETING THEN

        INSERT INTO PAGAMENTO_LOG (
            ID_LOG,
            ID_PAGAMENTO,
            OPERACAO,
            DATA_OPERACAO,
            USUARIO_BANCO,
            VALOR_ANTIGO
        )
        VALUES (
            SEQ_PAGAMENTO_LOG.NEXTVAL,
            :OLD.ID_PAGAMENTO,
            'DELETE',
            SYSTIMESTAMP,
            USER,
            :OLD.VALOR
        );

    END IF;

END;
/
