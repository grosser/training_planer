FactoryGirl.define do
  factory :webinar do |f|
    f.title 'Introduction'
    f.description 'Here you learn the basics'
    f.start '2012-01-01 18:00:00'
  end

  #factory :webinar do |f|
  #  f.title 'Bla, Inc'
  #  f.website 'bla.com'
  #  f.address '123 Bla street 94103 San Francisco'
  #end
end
