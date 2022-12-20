CREATE DATABASE pratica_integridade;
CREATE TYPE phone AS ENUM ('landline','mobile');
CREATE TYPE transaction AS ENUM ('deposit','transactions');

CREATE TABLE states(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE cities(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR (150) NOT NULL    
);

CREATE TABLE customers(
    "id" SERIAL PRIMARY KEY,
    "fullName" VARCHAR(100) NOT NULL,
    "cpf" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL 
);

CREATE TABLE customersPhones(
    "id" SERIAL PRIMARY KEY,
    "number" TEXT NOT NULL UNIQUE,
    "type" phone 
);

CREATE TABLE customersAddresses(
    "id" SERIAL PRIMARY KEY,
    "street" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "complement" TEXT NOT NULL,
    "postalCode" TEXT NOT NULL
);

CREATE TABLE bankAccount(
    "id" SERIAL PRIMARY KEY,
    "accountNumber" TEXT NOT NULL UNIQUE,
    "agency" TEXT NOT NULL,
    "openDate" DATE NOT NULL DEFAULT NOW(),
    "closeDate" DATE NOT NULL
);

CREATE TABLE transactions(
    "id" SERIAL PRIMARY KEY,
    "amount" INTEGER NOT NULL,
    "type" transaction,
    "time" TIMESTAMP DEFAULT NOW(),
    "description" TEXT NOT NULL,
    "cancelled" BOOLEAN DEFAULT FALSE 
);

CREATE TABLE creditCards(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "securityCode" TEXT NOT NULL UNIQUE,
    "expirationMonth" DATE NOT NULL,
    "expirationYear" DATE NOT NULL,
    "password" TEXT NOT NULL,
    "limit" INTEGER NOT NULL
);

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("stateId") REFERENCES "states"("id");

ALTER TABLE "customersPhone" ADD CONSTRAINT "cp_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "customersAddresses" ADD CONSTRAINT "ca_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "customersAddresses" ADD CONSTRAINT "ca_fk1" FOREIGN KEY ("cityId") REFERENCES "cities"("id");

ALTER TABLE "bankAccount" ADD CONSTRAINT "ba_fk0"  FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "transactions" ADD CONSTRAINT "t_fk0" FOREIGN KEY ("bankAccountId") REFERENCES "bankAccount"("id");

ALTER TABLE "creditCards" ADD CONSTRAINT "c_fk0" FOREIGN KEY ("bankAccountId")  REFERENCES "bankAccount"("id");
