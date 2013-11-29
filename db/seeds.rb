# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'digest/md5'

#ThuApp.create(appid: 'test_app', name: 'Just For Test', seq: 0, prefix: 'http://localhost:3000', default_path: '')
#Md5Map.create(md5: Digest::MD5.hexdigest('test_app'), appid: 'test_app')
#User.create(thuid: '2010010001', username: 'student_1', password: Digest::MD5.hexdigest("1234561"), real_name: 'Student 1', user_type: 'X0011', department: 'SaaS', email: 'student_1@email.com')
#User.create(thuid: '2010010002', username: 'student_2', password: Digest::MD5.hexdigest("1234562"), real_name: 'Student 2', user_type: 'X0011', department: 'SaaS', email: 'student_2@email.com')
#User.create(thuid: '2010010003', username: 'student_3', password: Digest::MD5.hexdigest("1234563"), real_name: 'Student 3', user_type: 'X0011', department: 'SaaS', email: 'student_3@email.com')
#User.create(thuid: '2010020001', username: 'teacher_1', password: Digest::MD5.hexdigest("1234561"), real_name: 'Teacher 1', user_type: 'J0000', department: 'SaaS', email: 'teacher_1@email.com')
#User.create(thuid: '2010020002', username: 'teacher_2', password: Digest::MD5.hexdigest("1234562"), real_name: 'Teacher 2', user_type: 'J0000', department: 'SaaS', email: 'teacher_2@email.com')

# Create 50 students
50.times do |i|
    user = User.where(thuid: "2010010%03d" % (i + 1)).first_or_initialize
    user.username = "student_%d" % (i + 1)
    user.password = Digest::MD5.hexdigest("123456%d" % (i + 1))
    user.real_name = "Student %d" % (i + 1)
    user.user_type = "X0011"
    user.department = "SaaS"
    user.email = "#{user.username}@email.com"
    user.save!
end

# Create 20 teachers
20.times do |i|
    user = User.where(thuid: "2010020%03d" % (i + 1)).first_or_initialize
    user.username = "teacher_%d" % (i + 1)
    user.password = Digest::MD5.hexdigest("123456%d" % (i + 1))
    user.real_name = "Teacher %d" % (i + 1)
    user.user_type = "J0000"
    user.department = "SaaS"
    user.email = "#{user.username}@email.com"
    user.save!
end

