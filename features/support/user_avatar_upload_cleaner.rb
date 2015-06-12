After('@upload_cleaned') do
  FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads/*"])
end