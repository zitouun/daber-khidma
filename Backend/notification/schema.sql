-- Conception semaine 4 : schéma principal à convertir en migrations après revue.
-- À exécuter uniquement dans la base du service notification.
-- Aucun FK vers une autre base. Aucun déploiement effectué.

CREATE TABLE notification (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    event_id UUID NOT NULL,
    type TEXT NOT NULL,
    read_at TIMESTAMPTZ,
    UNIQUE (event_id, user_id, type)
);

CREATE TABLE preference (
    user_id UUID NOT NULL,
    email_enabled BOOLEAN NOT NULL,
    in_app_enabled BOOLEAN NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE delivery_attempt (
    id UUID PRIMARY KEY,
    notification_id UUID NOT NULL,
    attempt INTEGER NOT NULL,
    status TEXT NOT NULL,
    next_attempt_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE inbox_event (
    consumer TEXT NOT NULL,
    event_id UUID NOT NULL,
    processed_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (consumer, event_id)
);

CREATE TABLE outbox_event (event_id UUID PRIMARY KEY, type TEXT NOT NULL, payload JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), published_at TIMESTAMPTZ);

-- FK internes à ajouter dans les migrations : relations du diagramme de classes.
-- Les enums et droits SQL doivent être précisés lors de la mise en œuvre.
