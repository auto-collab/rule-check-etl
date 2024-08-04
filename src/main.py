from config_loader import ConfigLoader
from src.db import DBInitializer
from src.query import query_loader
from src.rule import RuleChecker


def main():
    ConfigLoader("../config.json")

    initializer = DBInitializer()

    db_manager = initializer.get_db_manager()

    queries = query_loader.load_queries_under_test("query/example_queries.sql")

    rule_checker = RuleChecker(db_manager)

    results = rule_checker.check_rules(queries)
    for i, result in enumerate(results):
        print(f"Query {i + 1} {'PASSED' if result else 'FAILED'}")


if __name__ == "__main__":
    main()
