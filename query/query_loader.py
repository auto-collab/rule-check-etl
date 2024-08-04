def load_queries_under_test(file_path: str) -> list:
    with open(file_path, "r") as file:
        queries = file.read()
    queries = queries.split(";")
    queries = [query.strip() for query in queries if query.strip()]
    return queries
