# if Rails.env.production?
#   Chewy.settings = {host: ENV['SEARCHBOX_URL']}
#   Chewy.settings = {prefix: Rails.env }
# else
#   Chewy.settings = {host: 'localhost:9250'}
#   Chewy.settings = {prefix: Rails.env }
# end

Chewy.use_after_commit_callbacks = !Rails.env.test?
