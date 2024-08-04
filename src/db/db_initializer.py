from .db_factory import DBFactory
from .db_manager import DBManager


class DBInitializer:
    def __init__(self, db_factory=None, connection_params=None):
        self.db_factory = db_factory or DBFactory()
        self._connection = self.db_factory.get_connection()
        self._db_manager = DBManager(self._connection)

    def get_connection(self):
        return self._connection

    def set_connection(self, connection):
        self._connection = connection
        self._db_manager = DBManager(connection)

    def get_db_manager(self):
        return self._db_manager

    def set_db_manager(self, db_manager):
        self._db_manager = db_manager

    def close_connection(self):
        if self._connection:
            self._connection.close()
            self._connection = None
