from typing import List
from db.db_manager import DBManager


class RuleChecker:
    def __init__(self, db_manager: DBManager):
        self.db_manager = db_manager

    def execute_query(self, query: str) -> List[tuple]:
        return self.db_manager.execute_query(query)

    def check_rule(self, query_result: List[tuple]) -> bool:
        for row in query_result:
            rule_under_test, schema_under_test, test_result = row
            if test_result != "PASS":
                return False
        return True

    def check_rules(self, queries: List[str]) -> List[bool]:
        results = []
        for query in queries:
            query_result = self.execute_query(query)
            result = self.check_rule(query_result)
            results.append(result)
        return results
