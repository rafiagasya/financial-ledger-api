 Double-Entry Financial Ledger API Service

A RESTful API service built with Ruby on Rails designed to process financial transactions using Double-Entry Bookkeeping logic. This service guarantees data consistency, prevents race conditions, and includes an interactive web-based API Explorer.

• Features

- Double-Entry Bookkeeping: Ensures every transaction creates corresponding debit and credit ledger entries to preserve financial balance integrity.
- Database Isolation & Atomicity: Prevents race conditions during balance updates using explicit database transactions.
- RESTful Endpoints: Clean API routes for executing transfers (POST /api/v1/transfers) and retrieving mutation logs (GET /api/v1/transfers).
- Built-in API Explorer: Lightweight web interface for real-time API payload testing and response status inspection.
- Docker Support: Containerized environment ready for deployment.

• Tech Stack

- Language: Ruby 3.2.x
- Framework: Ruby on Rails 8.0.x
- Database: SQLite3 / PostgreSQL
- Containerization: Docker & Docker Compose
- Frontend UI: Bootstrap 5 (API Explorer Client)

• Quick Start with Docker

1. Clone the repository:
   git clone https://github.com/rafiagasya/financial-ledger-api.git
   cd financial-ledger-api

2. Run using Docker Compose:
   docker compose up --build

3. Access the API Explorer:
   Open your browser and navigate to http://localhost:3000

• API Endpoints

• API Endpoints

- POST /api/v1/transfers - Executes balance transfer between two wallets
- GET /api/v1/transfers - Fetches transaction history logs in JSON format
