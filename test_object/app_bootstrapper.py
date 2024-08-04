from db import DBFactory, DBManager
from query import RuleChecker


class AppBootstrapper:
    def __init__(self):
        self.db_factory = DBFactory()
        self.connection = self.db_factory.get_connection()
        self.db_manager = DBManager(self.connection)
        self.rule_checker = RuleChecker(self.db_manager)

    def get_rule_checker(self) -> RuleChecker:
        return self.rule_checker
