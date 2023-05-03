User.create(email: "admin1@example.com", password: "admin1@example.com", password_confirmation: "admin1@example.com")

User.update_all confirmed_at: DateTime.now