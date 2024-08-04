from typing import List, Dict, Any, Tuple


class DBManager:
    def __init__(self, connection):
        self.connection = connection

    def execute_query(self, query: str) -> List[Tuple[str, str, str]]:
        cursor = self.connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        return results
