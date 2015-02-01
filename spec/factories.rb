FactoryGirl.define do
  factory :user do
    name     "Alex Grib"
    email    "alex.git@ukr.net"
    password "foobar"
    password_confirmation "foobar"
  end
end