-- .read Lesson/1.21_DDL_DML_Part1.sql

USE data_jobs;

DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE IF NOT EXISTS jobs_mart

SHOW DATABASES;

SELECT *
FROM information_schema.schemata;


USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

--DROP SCHEMA staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER,
    role_name VARCHAR

);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

DROP TABLE IF EXISTS preferred_roles;