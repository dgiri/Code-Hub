# require 'paperclip'
# # Use *which convert* to see where the ImageMagick binary is located
# # Replace this path variable with that.
# imagemagick_installation_binary = "/opt/local/bin"
# Paperclip.options.merge!(:command_path => imagemagick_installation_binary)

Paperclip.options[:image_magick_path] = "/opt/local/bin"