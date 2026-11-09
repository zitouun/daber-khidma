-- Conception semaine 4 : schéma principal à convertir en migrations après revue.
-- À exécuter uniquement dans la base du service proposal.
-- Aucun FK vers une autre base. Aucun déploiement effectué.

CREATE TABLE proposal (
    id UUID PRIMARY KEY,
    project_id UUID NOT NULL,
    freelancer_id UUID NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    currency TEXT NOT NULL,
    status TEXT NOT NULL,
    CHECK (amount >= 0)
);

CREATE TABLE proposal_version (
    id UUID PRIMARY KEY,
    proposal_id UUID NOT NULL,
    version INTEGER NOT NULL,
    cover_letter TEXT NOT NULL
);

CREATE TABLE selection (
    project_id UUID NOT NULL UNIQUE,
    proposal_id UUID NOT NULL UNIQUE,
    reservation_key UUID NOT NULL UNIQUE,
    status TEXT NOT NULL,
    PRIMARY KEY (project_id)
);

CREATE TABLE outbox_event (
    event_id UUID NOT NULL,
    type TEXT NOT NULL,
    payload JSONB NOT NULL,
    published_at TIMESTAMPTZ
);

CREATE TABLE inbox_event (consumer TEXT NOT NULL, event_id UUID NOT NULL, processed_at TIMESTAMPTZ NOT NULL DEFAULT now(), PRIMARY KEY (consumer, event_id));
CREATE UNIQUE INDEX proposal_one_active_per_freelancer ON proposal(project_id, freelancer_id) WHERE status IN ('SUBMITTED','SHORTLISTED','ACCEPTED');
CREATE TABLE award_intent (id UUID PRIMARY KEY, proposal_id UUID NOT NULL UNIQUE, reservation_key UUID NOT NULL UNIQUE, status TEXT NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now());
-- Selection est identifiée dans l’API par proposal_id; project_id reste la clé locale de verrou.

-- FK internes à ajouter dans les migrations : relations du diagramme de classes.
-- Les enums et droits SQL doivent être précisés lors de la mise en œuvre.
