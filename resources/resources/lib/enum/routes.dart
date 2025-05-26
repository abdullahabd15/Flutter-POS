enum Routes {
  home('/', 'Point of Sales'),
  login('/login', 'Login'),
  register('/register', 'Register'),
  forgotPassword('/forgot-password', 'Forgot Password'),
  transactions('/transactions', 'Transaction History'),
  report('/report', 'Report');

  final String route;
  final String title;

  const Routes(this.route, this.title);
}
