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

	    after(:create) do |church, evaluator|
	      create_list(:service, evaluator.num_services, church: church)
	    end
    end

    factory :service do
	    church
	    transient { num_rides 1 }

	    after(:create) do |service, evaluator|
	      create_list(:ride, evaluator.num_rides, service: service)
	    end
    end

    factory :ride do
      user
      service
    end

    factory :user_ride do
      ride
      user
    end
end
