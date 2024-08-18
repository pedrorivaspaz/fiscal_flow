# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# /app/assets
Rails.application.config.assets.precompile += %w( application.css )
Rails.application.config.assets.precompile += %w(site.js site.css )
Rails.application.config.assets.precompile += %w( maino1.png )
Rails.application.config.assets.precompile += %w( maino.png )
Rails.application.config.assets.precompile += %w( profile.png )

# /lib/assets
Rails.application.config.assets.precompile += %w( sb-admin-2.js sb-admin-2.css
                                                  custom.js custom.css
                                                  img.jpg
                                                  surface-fix.js surface-fix.css
                                                  navbar.css )
# /vendor/assets
Rails.application.config.assets.precompile += %w( jquery-2.2.3/dist/jquery.js )