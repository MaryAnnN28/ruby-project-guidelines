require_relative '../config/environment'



puts "HELLO WORLD"

request = NbaRb::Player::Summary.new(player_id: '203507')
