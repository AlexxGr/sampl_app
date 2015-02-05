#  Это тут было
#require 'rails_helper'

#RSpec.describe User, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

# Это мы введем ====================
require 'spec_helper'

describe User do

# - это (ниже) ПОЛНЫЙ блок, С do и END  
# добавим для в хеш инициализации password: "foobar", password_confirmation: "foobar"
  before do
  	@user = User.new(  name: "Example User", email: "user@example.com", 
                       password: "foobar",   password_confirmation: "foobar")
  end	

# - это сокращенный блок, без do и END
#  before { @user = User.new(name: "Example User", email: "user@example.com") }

# субъкт @user позволяет писать однострочные проверки
  subject { @user }
# ========== 
# тесты на существоание метода у объекта
# =================
# 
  it { should respond_to(:name) } # имеет ли модель user метод name
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  
  # проверка на валидность субъекта @user

  it { should be_valid }

# тест вначале назначает пользовательскому имени недопустимое значение, 
# а затем проверяет что получившийся объект @user невалиден

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
# Здесь используется блок before для назначения невалидного значения атрибуту name, 
# а затем происходит проверка того что получившийся объект user невалиден.
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
# проверка длины (не больше 50 символов) использована мультипликация строки
  describe "when name is too long" do
    before { @user.name = "a"*51 }
    it { should_not be_valid }
  end

 # проверка на формат почтового ящика
 describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

# тест на уникальность адреса электроной почты
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
# нечувствительный к регистру тест для отклонения дублирубщих адресов
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

# pass not empty
  
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
# проверка на совпадение паролей

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end



  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
      
      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end
      
      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }
        
        it { should_not == user_for_invalid_password }
        specify { expect(user_for_invalid_password).to be false }
      end
  end

# Тест на валидный (не пустой) remember token. 
  describe "remember token" do 
    before { @user.save}
    it { expect(@user.remember_token).not_to be_blank }
    #its(:remember_token) { should_not be_blank}
  end
end