import pyodbc
from .connection_string_factory import ConnectionStringFactory


class DBFactory:
    def __init__(self):
        self.connection_string_factory = ConnectionStringFactory()

    def get_connection(self):
        connection_string = self.connection_string_factory.build_connection_string()
        return pyodbc.connect(connection_string)
