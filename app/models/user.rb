class User < ActiveRecord::Base
	# attr_accessor :name, :email, :password, :password_confirmation
	# перевод адреса эл.почты в нижний регистр перед записаю
	# по туториалу было attr_accessible. Однаков Rails 4 attr_accessible
	# ЗАМЕНЕН НА attr_accessor
=begin
	attr_accessor :name, :email
	before_save { |user| user.email = email.downcase }
=end
	#before_save { self.email = email.downcase }
	before_save { email.downcase! } # это аналогично верхнему
	# валидация наличия name атрибута + добавляем валидацию длины не больше 50 симоволов
	validates :name, 	presence: true, length: { maximum:50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, 	presence: true, format: { with: VALID_EMAIL_REGEX },
  						uniqueness: { case_sensitive: false }
  	# 				вместо	uniqueness: true	ставим { case_sensitive: false }
	# не сокращенная формула выше
	# validates(:name, presence: true)
	# строка для прохождения тестов пароля
	has_secure_password
	validates :password, length: {minimum:6}
	
end
