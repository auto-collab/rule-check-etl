import json
from typing import Any, Dict


class ConfigLoader:
    _instance = None
    _config_file = "../config.json"

    def __new__(cls, config_file: str = None):
        if cls._instance is None:
            cls._instance = super(ConfigLoader, cls).__new__(cls)
            if config_file:
                cls._config_file = config_file
            cls._instance._load_config(cls._config_file)
        return cls._instance

    def _load_config(self, config_file: str):
        with open(config_file, "r") as file:
            self.config = json.load(file)

    @classmethod
    def get_instance(cls) -> "ConfigLoader":
        if cls._instance is None:
            cls._instance = ConfigLoader(cls._config_file)
        return cls._instance

    def get(self, key: str) -> Any:
        return self.config.get(key, None)

    def get_db_config(self) -> Dict[str, Any]:
        return self.config.get("db_config", {})

    def get_connection_templates(self) -> Dict[str, str]:
        return self.config.get("connection_templates", {})
