# encoding: utf-8
FactoryGirl.define do
  factory :medicion do
    grd_id        { rand(10) }
    valor         { rand(5000) }
    concentracion { rand }
    created_at    { DateTime.now }
  end
end
