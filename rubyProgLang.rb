# Ruby solution to Homework
# 	Author: Justin Gavin
#
#input is to be passed as arguments of the form:
#	~$ rubyProgLang.rb voterOpinion candidate1 candidate2...
#	
#	Example:
#	~$ rubyProgLang.rb 1,0,1 "Adam",-1,-1,-1 "James",1,1,1 "Joe",0,1,1
	

def bestCand(voterOpinion, candList)
	topCands = Array.new # []
	topScore = nil
	
	# for each element in the candList array, calling the current element cand.
	#	the {/} are the same as the do/end shown in the Main section. 
	#	Included here to show the availabailty for different style choices
	candList.each { |cand| 
					currScore = getCandScore(voterOpinion,cand.drop(1))
					if topScore.nil? then
						topScore = currScore
					end
					unless currScore < topScore # essentially if !(currScore < topScore)
						
						if currScore == topScore
							topCands.push(cand[0])
						else # must be greater
							topScore = currScore
							topCands = [cand[0]]
						end
					end
				}
				
	return topCands
end

def getCandScore(voterOpinion,candOpinion)
	result = 0
	for i in 0..(voterOpinion.length-1) 
		if !(voterOpinion[i] == 0) && !(candOpinion[i] == 0) then
			if voterOpinion[i] == candOpinion[i]
				result = result + 1 
			else 
				result = result - 1
			end			
		end	
	end
	return result
end



#### Main ####


# ARGV is the array containing the arguments
# The first argument will always be the voter opinion, "1,0,1,..."
voter = ARGV[0].split(",").map(&:to_i)

candList = []

# for each element in the array ARGV, excluding the first argument, the current element is elm
ARGV.drop(1).each do |elm|
	#Turn "Name,1,0,1,..." into ["Name","1","0","1",...]
	tempArray = elm.split(",")
	
	# Adding to the end of the candList array:
	candList.push(
		# excluding the first element, the result of converting each element to an integer;
		#	insert "Name" at the beginning
		tempArray.drop(1).map(&:to_i).unshift(tempArray[0])	
		)
end

print bestCand(voter,candList)

