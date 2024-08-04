from config_loader import ConfigLoader
from query.query_loader import load_queries_under_test
from test_object.app_bootstrapper import AppBootstrapper


def main():
    ConfigLoader("config.json")

    # Creates connection string and database connection
    bootstrapper = AppBootstrapper()

    rule_checker = bootstrapper.get_rule_checker()

    # Loads test queries
    queries = load_queries_under_test("query/example_queries.sql")

    results = rule_checker.check_rules(queries)
    for i, result in enumerate(results):
        print(f"Query {i + 1} {'PASSED' if result else 'FAILED'}")


if __name__ == "__main__":
    main()
