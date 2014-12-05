FactoryGirl.define do

  factory :user do
    sequence(:name) { |i| "User #{i}" }
	  sequence(:email) { |i| "user.#{i}@example.com" }
	  password 'password'
	  password_confirmation 'password'
    admin false

	 factory :admin do
     sequence(:name) { |i| "Admin #{i}" }
     admin true
  	end
  end

    factory :church do
      user
	    transient { num_services 1 }
      
      sequence(:name) { |i| "Church #{i}" }
      
	    after(:create) do |church, evaluator|
	      create_list(:service, evaluator.num_services, church: church)
	    end
    end

    factory :service do
	    church
	    transient { num_rides 1 }

      start_time Time.new(8)
      finish_time Time.new(10)
      day_of_week "Sunday"
      location "church sanctuary"
      
	    after(:create) do |service, evaluator|
	      create_list(:ride, evaluator.num_rides, service: service)
	    end
    end

    factory :ride do
      user
      service
      
      number_of_seats 4
      seats_available 4
      meeting_location 'the spot to meet'
      vehicle 'a red car'
      
      leave_time Time.at(Time.now()+60*60*26) #26 hours from the time it is created
      return_time Time.at(Time.now()+60*60*29) #3 hours after the leave_time
      date Date.today()+1
      
      created_at Date.today()-2
    end

    factory :user_ride do
      ride
      user
    end
end
