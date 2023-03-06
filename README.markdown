# Plutus Fork for Code Challenge Assignment

This is a fork of the Plutus Ruby on Rails Engine which provides a double entry accounting system for applications.  This fork has been modified to support a code-challenge assignment (the "Main App"). 

A summary of the changes to this engine is provided below:

1. The Main App has a model "Entity" which represents an organization. This Plutus engine was modified to support the necessary Plutus::Account belongs_to MainApp::Entity relationship.

2. This Plutus engine was modified to allow the creation of new Plutus::Accounts with an account_type field (e.g. Equity, Assets, etc.)

3. This Plutus engine was modified to pre-fetch (include) MainApp::Entity records in the index action. This was done to prevent "N+1" queries when rendering a table of Plutus::Account records.

4. The ransack gem was bundled to support basic search functionality in the Main App.

