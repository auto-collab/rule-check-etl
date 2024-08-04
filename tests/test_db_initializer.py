import pytest

from src.db import DBInitializer, DBManager


@pytest.fixture
def db_initializer():
    initializer = DBInitializer()
    yield initializer
    initializer.close_connection()


def test_get_connection(db_initializer):
    connection = db_initializer.get_connection()
    assert connection is not None


def test_get_db_manager(db_initializer):
    db_manager = db_initializer.get_db_manager()
    assert isinstance(db_manager, DBManager)
