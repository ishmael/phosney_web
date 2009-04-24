# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_phosney_session',
  :secret      => 'b15cc5d9988b9a62990d34e83b4bf6f2abe8ae5f773259f93a13d2945b134c7fc8d6f14a20d69bd0f5c0e357efffc115a65a4345dc7ab886c492e7bd130ce1f0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
 ActionController::Base.session_store = :active_record_store
