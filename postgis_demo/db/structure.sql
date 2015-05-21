--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

--
-- Name: update_tweet_geom(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_tweet_geom() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          NEW.geom := ST_GeomFromEWKT('SRID=3857;POINT (' || NEW.lng || ' ' || NEW.lat || ')');
          RETURN NEW;
        END;
      $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tweets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tweets (
    id integer NOT NULL,
    "time" character varying,
    tweet_id character varying,
    language character varying,
    country_code character varying,
    lat double precision,
    lng double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    geom geometry(Point,3857)
);


--
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tweets_id_seq OWNED BY tweets.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tweets ALTER COLUMN id SET DEFAULT nextval('tweets_id_seq'::regclass);


--
-- Name: tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (id);


--
-- Name: idx_tweets_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_tweets_on_geom ON tweets USING gist (geom);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: trigger_update_geom_on_tweet_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_update_geom_on_tweet_update BEFORE INSERT OR UPDATE ON tweets FOR EACH ROW EXECUTE PROCEDURE update_tweet_geom();


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150519144106');

INSERT INTO schema_migrations (version) VALUES ('20150519184114');

INSERT INTO schema_migrations (version) VALUES ('20150519184646');

INSERT INTO schema_migrations (version) VALUES ('20150519190126');

INSERT INTO schema_migrations (version) VALUES ('20150519192132');

