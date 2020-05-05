Bundler.require
require 'dotenv'
if defined? APP_ENV && APP_ENV == 'test'
  Dotenv.load("./.env.test")
else
  Dotenv.load("./.env")
end
require 'json'
Dir.glob(File.join('./lib', '**', '*.rb'), &method(:require))

require "google/apis/calendar_v3"
require "google/apis/admin_directory_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "date"
require "fileutils"

