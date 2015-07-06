CarrierWave.configure do |config|

  if Rails.env.test? or Rails.env.cucumber?
      config.storage = :file
      config.enable_processing = false
  end

  if Rails.env.development?
    config.storage = :file
  end

  if Rails.env.environment?
    config.storage = :fog
  end

end
