# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_recipe_box_session',
  :secret      => '5d8d1735c9fa007dd4a226a597f89bb1ddde263038345f9da2b786e3f6045f5b785db6477248ddf7e0d0b66e7151a3ab3329465b64677c53b21f9d94f942c8d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
