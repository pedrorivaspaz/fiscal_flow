web: bin/rails assets:precompile && rake db:migrate && bin/rails server -b 0.0.0.0 -p ${PORT:-3000}
worker: bundle exec sidekiq -C config/sidekiq.yml