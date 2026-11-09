-- Conception semaine 4 : schéma principal à convertir en migrations après revue.
-- À exécuter uniquement dans la base du service communication.
-- Aucun FK vers une autre base. Aucun déploiement effectué.

CREATE TABLE conversation (
    id UUID PRIMARY KEY,
    contract_id UUID NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE participant (
    conversation_id UUID NOT NULL,
    user_id UUID NOT NULL,
    joined_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (conversation_id, user_id)
);

CREATE TABLE message (
    id UUID PRIMARY KEY,
    conversation_id UUID NOT NULL,
    sender_id UUID NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE attachment (
    id UUID PRIMARY KEY,
    message_id UUID NOT NULL,
    object_key TEXT NOT NULL,
    mime_type TEXT NOT NULL,
    size_bytes BIGINT NOT NULL
);

CREATE TABLE read_receipt (
    message_id UUID NOT NULL,
    user_id UUID NOT NULL,
    read_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (message_id, user_id)
);

CREATE TABLE outbox_event (event_id UUID PRIMARY KEY, type TEXT NOT NULL, payload JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), published_at TIMESTAMPTZ);
CREATE TABLE inbox_event (consumer TEXT NOT NULL, event_id UUID NOT NULL, processed_at TIMESTAMPTZ NOT NULL DEFAULT now(), PRIMARY KEY (consumer, event_id));

-- FK internes à ajouter dans les migrations : relations du diagramme de classes.
-- Les enums et droits SQL doivent être précisés lors de la mise en œuvre.
