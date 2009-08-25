# You need to 
# require 'walruz/policies'
# in your spec_helper.rb file


class Policies::<%= class_name %>Test < Test::Unit
  
  def setup
    # setup associations btw actor and subject
  end

  def test_return_true_with_valid_association_of_actor_and_subject
    # assert Walruz.satisfies?(actor, :<%= file_name %>, subject)
  end
  
  def test_return_false_with_invalid_association_of_actor_and_subject
    # assert !Walruz.satisfies?(actor, :<%= file_name %>, subject) 
  end
  
end
