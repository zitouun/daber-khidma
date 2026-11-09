-- Socle commun : authentification et comptes. Pas de profil professionnel dans cette base.
CREATE TABLE user_account (id UUID PRIMARY KEY, oidc_subject TEXT NOT NULL UNIQUE, handle TEXT NOT NULL, email TEXT NOT NULL, email_verified BOOLEAN NOT NULL DEFAULT false, status TEXT NOT NULL);
CREATE TABLE role_assignment (user_id UUID NOT NULL REFERENCES user_account(id), role TEXT NOT NULL, PRIMARY KEY(user_id,role));
CREATE TABLE outbox_event (event_id UUID PRIMARY KEY, type TEXT NOT NULL, payload JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), published_at TIMESTAMPTZ);
CREATE TABLE inbox_event (consumer TEXT NOT NULL, event_id UUID NOT NULL, processed_at TIMESTAMPTZ NOT NULL DEFAULT now(), PRIMARY KEY(consumer,event_id));
