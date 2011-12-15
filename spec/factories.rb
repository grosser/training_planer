FactoryGirl.define do
  factory :training do |f|
    f.title 'Introduction'
    f.description 'Here you learn the basics'
    f.start '2012-01-01 18:00:00'
  end

  factory :person do |f|
    f.first_name 'John'
    f.last_name 'Doe'
    f.address '123 Wood Street, 94607, Oakland, CA'
    f.email{ "bla#{rand 999999999 }@blub.com" }
  end
end
