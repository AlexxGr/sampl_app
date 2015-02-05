FactoryGirl.define do
  factory :user do
    name     "Alexandr Grib"
    email    "alexx@email.com"
    password "foobar"
    password_confirmation "foobar"
  end
end