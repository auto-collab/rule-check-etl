class TestObject:
    def __init__(self, connection, db_manager, rule_checker, config):
        self.connection = connection
        self.db_manager = db_manager
        self.rule_checker = rule_checker
        self.config = config

    def get_connection(self):
        return self.connection

    def get_db_manager(self):
        return self.db_manager

    def get_rule_checker(self):
        return self.rule_checker

    def get_config(self):
        return self.config
