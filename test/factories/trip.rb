FactoryGirl.define do
  factory :trip do
    trip_reason 'Moscow besuch'
    trip_start { '12/05/2017 12:00'.to_datetime }
    trip_end {'15/05/2017 12:00'.to_datetime }
    night_count 0
    breakfast_count 0
    lunch_count 0
    dinner_count 0
    user
  end
end
