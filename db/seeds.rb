# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'byebug'
puts "Generating cats..."
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Black',
    sex: 'M',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Black',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'White',
    sex: 'M',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'White',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Grey',
    sex: 'M',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Grey',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Tuxedo',
    sex: 'M',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Tuxedo',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Orange',
    sex: 'M',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Orange',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Tabby',
    sex: 'M',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Tabby',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
25.times do
  c = Cat.new(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: 10.years.ago, to: Date.yesterday),
    color: 'Calico',
    sex: 'F',
    description: Faker::Marketing.buzzwords
  )
  unless c.save
    next
  end
end
puts "Cats generated!"
cat_count = Cat.all.count
puts "Generating requests!"
1000.times do
  cat_id = 1 + rand(cat_count)
  start_date = Faker::Date.between(from: Date.today, to: Date.today + 1.week)
  end_date = Faker::Date.between(from: Date.today + 8.days, to: Date.today + 1.month)
  crr = CatRentalRequest.new(cat_id: cat_id, start_date: start_date, end_date: end_date)
  unless crr.save!
    next
  end
end
puts "Requests generated!"

# puts "Attempting to approve requests"
# CatRentalRequest.all.each do |request|
#   unless request.update(status: 'APPROVED')
#     request.status = 'DENIED'
#     request.save
#   end
# end
# puts "Requests approved!"