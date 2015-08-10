module ApplicationHelper

  def reputation(a)
		total = 0 
 		a.user.answers.each do |x| 
			total += x.votes_for.up.count
		end
		total 
  end 
end
