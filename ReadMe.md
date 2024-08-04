# ETL Rule Check Application

This project is designed to compare the results of SQL queries to test the transformation part of an ETL (Extract, Transform, Load) process. It verifies whether the data transformation rules are correctly applied by comparing data across landing, staging, and production tables.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Queries](#queries)
- [Running the Application](#running-the-application)
- [Troubleshooting](#troubleshooting)

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/etl-rule-check.git
    cd etl-rule-check
    ```

2. **Create a virtual environment and activate it:**

    ```bash
    python -m venv .venv
    source .venv/bin/activate  # On Windows, use `.venv\Scripts\activate`
    ```

3. **Install the dependencies:**

    ```bash
    pip install -r requirements.txt
    ```

## Usage

This application is designed to test the transformations between landing, staging, and production tables. It compares the results of SQL queries to determine if the transformation rules are correctly applied.

## Configuration

Configuration settings, including database connection details and connection string templates, are stored in `config.json`. Here is an example of the configuration file:

```json
{
    "db_config": {
        "type": "sqlserver",
        "Driver": "SQL Server",
        "server": "your_server_name",
        "database": "your_database_name",
        "user": "your_username",
        "password": "your_password"
    },
    "connection_templates": {
        "sqlserver": "Driver={Driver};Server={server};Database={database};TrustServerCertificate=yes;Trusted_Connection=yes;",
        "mysql": "DRIVER={Driver};SERVER={server};DATABASE={database};USER={user};PASSWORD={password};",
        "sqlite": "DRIVER={Driver};DATABASE={database};"
    }
}
