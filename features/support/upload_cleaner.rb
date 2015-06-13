After('@upload_cleaned') do
  FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
end