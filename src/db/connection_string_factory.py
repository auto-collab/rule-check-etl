from src.config_loader import ConfigLoader


class ConnectionStringFactory:
    def __init__(self):
        config_loader = ConfigLoader.get_instance()
        self.templates = config_loader.get_connection_templates()

    def build_connection_string(self) -> str:
        config_loader = ConfigLoader.get_instance()
        db_config = config_loader.get_db_config()
        db_type = db_config["type"]
        if db_type in self.templates:
            template = self.templates[db_type]
            # Unpacks config values and assigns them to the string args
            return template.format(**db_config)
        else:
            raise ValueError(f"Unsupported database type: {db_type}")
