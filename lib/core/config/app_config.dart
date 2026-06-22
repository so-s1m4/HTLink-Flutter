class AppConfig {
  const AppConfig({
    this.baseUrl = 'https://api.example.com',
    this.useMockData = true,
    this.authToken = 'token',
  });

  final String baseUrl;
  final bool useMockData;
  final String authToken;
}
