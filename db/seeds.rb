require "open-uri"

puts "Destroying past seeds..."
Supermarket.destroy_all
User.destroy_all

puts "Creating Supermarkets..."
am_pm = Supermarket.new(name: 'am:pm')
shufersal = Supermarket.new(name: 'Shufersal')
am_pm_photo = URI.open('https://storage.googleapis.com/sp-public/retailers/2/icon.png?0.7664989696733078')
shufersal_photo = URI.open('https://lh3.googleusercontent.com/kkz7tPp3Mdy5PuVK1hE1YNNJgkrGNAJWRDRZ7lvXLQ1StDzN-4qwa7tPkZcVu4b_KQ')
am_pm.photo.attach(io: am_pm_photo, filename: 'ampm.png', content_type: 'image/png')
shufersal.photo.attach(io: shufersal_photo, filename: 'shufersal.png', content_type: 'image/png')

am_pm.save!
shufersal.save!

#####################################################################################################################
