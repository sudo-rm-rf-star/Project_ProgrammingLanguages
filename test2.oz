functor
import
   Browser(browse:Browse)
	System(showInfo:Print)
define
	%GameState = state(wins: 0)
	%{Browse {Record.adjoin GameState state(wins: 1)}}

	
	local Player1S Player2S RefS Player1P Player2P RefP in 
		proc {ReadStream PlayerStream}
			{Delay 100}
			case PlayerStream 
			of X|Xs then {Port.send RefP X} {ReadStream Xs}
			else skip 
			end 
		end 	

		proc {ReadRefStream RefStream} 
			case RefStream
			of X|Xs then {Print ref#': '#X} {ReadRefStream Xs}
			else skip
			end 
		end 

		proc {Referee}
			local GenerateList in 
				proc  {GenerateList Port1 N Limit}
					if N < Limit then {Port.send Port1 N} {GenerateList Port1 N+1 Limit} end 
				end 
			thread {GenerateList Player1P 1 30 } end 
			thread {GenerateList Player2P 1 25 } end 
			{ReadRefStream RefS}
			end 
		end 

		proc {Game}
			thread 
			{Delay 500}
			{ReadStream Player1S}
			end 
			thread 
			{Delay 500}
			{ReadStream Player2S} 
			end 
			thread 
			{Referee}
			 end 
		end 
		{Port.new Player1S Player1P}
		{Port.new Player2S Player2P}
		{Port.new RefS RefP}
		{Game}
	end 


end