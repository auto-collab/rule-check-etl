import pytest
from src.config_loader import ConfigLoader


@pytest.fixture(scope="module")
def config_loader():
    return ConfigLoader("config.json")


def test_load_config(config_loader):
    assert config_loader.get_db_config() is not None
    assert config_loader.get_connection_templates() is not None


def test_singleton_behavior():
    config_loader1 = ConfigLoader("config.json")
    config_loader2 = ConfigLoader()
    assert config_loader1 is config_loader2


if __name__ == "__main__":
    pytest.main()
