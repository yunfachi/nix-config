{delib, ...}:
delib.module {
  name = "programs.schizofox";

  home.ifEnabled.programs.schizofox.search = {
    defaultSearchEngine = "Brave";
    addEngines = [
      {
        Name = "Brave";
        Description = "Brave engine";
        Alias = "!brave";
        Method = "GET";
        URLTemplate = "https://search.brave.com/search?q={searchTerms}";
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
