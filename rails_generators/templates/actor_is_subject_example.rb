# This method is pretty useful when used with the `for_subject` method
# See http://walruz.rubyforge.org/ for more info.
#
class Policies::ActorIsSubject < Walruz::Policy
  
  def authorized?(actor, subject)
    actor == subject
  end
  
end