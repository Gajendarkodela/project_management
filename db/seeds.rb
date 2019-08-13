# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p "#"*100
p "Admin Creation"
p "email: admin@promobi.com"
p "password: admin123"
p "#"*100
admin = Admin.create({
					name: 'admin',
					email: 'admin@promobi.com',
					password: 'admin123'
				})
15.times do |counter|
  Admin.first.projects.create({
  	    name: "project#{counter}"
      })

  Developer.create({
  	name: "developer#{counter}",
  	email: "developer#{counter}@gmail.com",
  	password: "developer#{counter}"
  })

end

Project.all.each do |p|
	7.times do |i|
  	p.todos.create({
  		description: "todo #{i}"
  	})
  end
end

Project.first.developers = Developer.where('id in (?)', [1,10])
statuses = ['New', 'InPorgress', 'Done']
Project.first.todos.each_with_index do |todo, index|
	todo.developer_id = Developer.first.id
	todo.status = statuses[index%3]
	todo.save
end

p "*"*100
p "one of developers login"
p "email: developer0@gmail.com"
p "password: developer0"
p "*"*100