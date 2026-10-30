/// Talks to your backend. Replace the bodies with real HTTP calls
/// (for example with the `http` or `dio` package) to your /backend API.
class AuthService {
  Future<void> login(String email, String password) async {
    // TODO: POST to your backend login endpoint and store the token.
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> signup(String name, String email, String password) async {
    // TODO: POST to your backend signup endpoint.
    await Future.delayed(const Duration(milliseconds: 600));
  }
}