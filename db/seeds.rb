# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Photo.delete_all
require 'fileutils'
Dir.chdir("#{Rails.root}/app/assets/images")
Dir.glob('**/*.{png,jpg}').each do |name|
  newName = name.gsub(/[^\u0000-\u007f]+/,'_')
  FileUtils.mv(name,newName) unless newName == name
  p = Photo.new(:name => File.basename(newName,File.extname(newName)))
  p.path = newName
  p.save!
end
