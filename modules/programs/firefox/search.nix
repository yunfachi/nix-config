{delib, ...}:
delib.module {
  name = "programs.firefox";

  home.ifEnabled.programs.schizofox.search = {
    defaultSearchEngine = "Google";
    removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" "Wikipedia (en)"];
    addEngines = [
      {
        Name = "Google";
        Description = "Google Search";
        Alias = "!google";
        Method = "GET";
        URLTemplate = "https://www.google.com/search?q={searchTerms}";
      }
      {
        Name = "Tronscan";
        Description = "Checking balances";
        Alias = "!tron";
        Method = "GET";
        URLTemplate = "https://tronscan.org/#/searchResult/{searchTerms}/accounts?type=tokens&address&contract";
      }
    ];
  };
}
