guard :rspec, cmd: "bundle exec rspec", :version => 2, :cli => "rspec --color --drb -r rspec/instafail -f RSpec::Instafail", :bundler => true, :all_after_pass => false, :all_on_start => false, :keep_failed => false do
    watch('spec/spec_helper.rb')                                           { "spec" }
    watch(%r{^spec/.+_spec\.rb})
    watch(%r{^lib/(.+)\.rb})                                               { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb})                                               { |m| "spec/application_spec.rb" }
    watch(%r{^(.+)\.rb})                                                   { |m| "spec/#{m[1]}_spec.rb" }
  end

