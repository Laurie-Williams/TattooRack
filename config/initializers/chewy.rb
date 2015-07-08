Chewy.settings = {host: 'localhost:9250'}
Chewy.settings = {prefix: Rails.env }

Chewy.use_after_commit_callbacks = !Rails.env.test?
