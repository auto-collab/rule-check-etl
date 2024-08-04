# Rule Check ETL (WIP)

This project is designed to compare the results of SQL queries to test the transformation part of an ETL (Extract, Transform, Load) process. It verifies whether the data transformation rules are correctly applied by comparing data across landing, staging, and production tables.


## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/auto-collab/RuleCheckETL.git
    cd RuleCheckETL
    ```

1. **Create a virtual environment and activate it:**

    ```bash
    python -m venv .venv
    source .venv\Scripts\activate`
    ```

1. **Install the dependencies:**

    ```bash
    pip install -r requirements.txt
    ```

### Optional: Build test example database

Open up **sql server** and run the sql script file named `etl_sample_setup.sql`.

This will create and populate 3 tables (Landing, Staging, and Production) with dummy data. 

## Usage

### Adding Test Queries
To add queries for testing, create a `.sql` file with your SQL queries. Each query should be delimited by a `;`. Here is an example format:

```sql
### `queries.sql`

-- Query to check email validity in staging
SELECT 'Check email validity in staging' AS RuleUnderTest,
       'staging' AS SchemaUnderTest,
       CASE WHEN (SELECT COUNT(*) FROM staging WHERE email NOT LIKE '%@%') = 0 
       THEN 'PASS' ELSE 'FAIL' END AS TestResult;

-- Add more queries here...
```
### Configuration

Populate the configuration section `db_config` with your database info. 
```json
{
    "db_config": {
        "type": "sqlserver", // Currently only supporting database types listed in the `connection_templates` section.
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
