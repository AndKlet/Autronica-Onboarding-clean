/// A service class that handles user data.
class UserService {
  Future<Object> getUser() async {
    return {
      'name': 'John Doe',
      'department': 'Engineering',
    };
  }
}
