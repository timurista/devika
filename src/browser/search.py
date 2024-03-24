import requests
from src.config import Config

class BingSearch:
    def __init__(self):
        self.config = Config()
        self.bing_api_key = self.config.get_bing_api_key()
        self.bing_api_endpoint = self.config.get_bing_api_endpoint() or "https://api.bing.microsoft.com/v7.0/search"
        self.query_result = None

    def search(self, query):
        if not self.bing_api_key:
            return "Bing API key not found in config file"
        headers = {"Ocp-Apim-Subscription-Key": self.bing_api_key}
        params = {"q": query, "mkt": "en-US"}

        try:
            response = requests.get(self.bing_api_endpoint, headers=headers, params=params)
            response.raise_for_status()
            self.query_result = response.json()
            return self.query_result
        except Exception as err:
            return err

    def get_first_link(self):
        return self.query_result["webPages"]["value"][0]["url"]

