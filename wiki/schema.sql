  CREATE DATABASE wiki;

  CREATE TABLE authors(
    id serial primary key,
    name varchar(255),
    age integer
  );

  CREATE TABLE documents(
    id serial primary key,
    name varchar(255),
    content text,
    author_id integer
  );

  CREATE TABLE subscribers(
    id serial primary key,
    name varchar(255),
    email varchar(255),
    doc_id integer
  );

  CREATE TABLE revisions(
    id serial primary key,
    older_title varchar(255),
    older_content text,
    doc_id integer
  );