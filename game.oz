functor 
import 
    Player at 'player.ozf'
    Referee at 'referee.ozf'
define 
      local PWhite PBlack Ref in 
        PWhite = {Player.createPlayer Ref white random}
        PBlack = {Player.createPlayer Ref black heuristic}
        Ref = {Referee.createReferee PWhite PBlack}
      end     
end 
