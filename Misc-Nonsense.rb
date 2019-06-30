# MEDIA QUERY SIZES

# @media (min-width:320px)  { /* smartphones, portrait iPhone, portrait 480x320 phones (Android) */ }
# @media (min-width:480px)  { /* smartphones, Android phones, landscape iPhone */ }
# @media (min-width:600px)  { /* portrait tablets, portrait iPad, e-readers (Nook/Kindle), landscape 800x480 phones (Android) */ }
# @media (min-width:801px)  { /* tablet, landscape iPad, lo-res laptops ands desktops */ }
# @media (min-width:1025px) { /* big landscape tablets, laptops, and desktops */ }
# @media (min-width:1281px)
# 
# # # using SendGrid's Ruby Library
# # # https://github.com/sendgrid/sendgrid-ruby


# require 'sendgrid-ruby'
# include SendGrid
# 
# from = Email.new(email: 'test@example.com')
# to = Email.new(email: 'dougdougmann@gmail.com')
# subject = 'Sending with SendGrid is Fun'
# content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
# mail = Mail.new(from, subject, to, content)
# 
# sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
# response = sg.client.mail._('send').post(request_body: mail.to_json)
# puts response.status_code
# puts response.body
# puts response.headers

#DEVISE LINK TO FORGOT PASSWORD PAGE

# <%- if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations' %>
#   <%= link_to "Forgot your password?", new_password_path(resource_name), :class => "login-devise-link" %>
# <% end %>







#GENERATE ROW OF CARDS ----- OLD CODE ----- #
# let counter = 0
# let row_length = props.cards.row_one.length
# props.cards.row_one.forEach((card) => {
#   let isAdjacentCardSelected = false
#   if (props.cards.row_one.length > 1) {
#     if (card.id === props.cards.row_one[1].id && props.selected.includes(props.cards.row_one[0].id)) {
#       isAdjacentCardSelected = true
#     }
#     if (card.id === props.cards.row_one[props.cards.row_one.length - 2].id && props.selected.includes(props.cards.row_one[props.cards.row_one.length - 1].id)) {
#       isAdjacentCardSelected = true
#     }
#   }
# 
#   let token = card.token
#   if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
#     let selectedClass = ""
#     if (props.selected.includes(card.id)) {
#       selectedClass = "card-selected"
#     }
#     let cardFunction
#     if (props.gemMode === false) {
#       cardFunction = props.handleSelectCard
#       if (card.gem && card.gem.id !== props.currentUser.id) {
#         cardFunction = props.handleGemmedCard
#       }
#     } else if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_one.push(<CardTile
#       key={card.id}
#       id={card.id}
#       which_card={card}
#       handleSelectCard={cardFunction}
#       selectedClass={selectedClass}
#       token={token}
#       type="card-in-game"
#       gem={card.gem}
#       currentUser={props.currentUser}
#       />)
#     } else {
#       let cardFunction = ""
#       if (props.gemMode === true) {
#         cardFunction = props.handleGemPlacement
#       }
#       row_one.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem} currentUser={props.currentUser}/>)
#     }
#   counter++
# })
# 
# counter = 0
# row_length = props.cards.row_two.length
# props.cards.row_two.forEach((card) => {
#   let isAdjacentCardSelected = false
# 
#   if (props.cards.row_two.length > 1) {
#     if (card.id === props.cards.row_two[1].id && props.selected.includes(props.cards.row_two[0].id)) {
#       isAdjacentCardSelected = true
#     }
#     if (card.id === props.cards.row_two[props.cards.row_two.length - 2].id && props.selected.includes(props.cards.row_two[props.cards.row_two.length - 1].id)) {
#       isAdjacentCardSelected = true
#     }
#   }
# 
#   let token = card.token
#   if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
#     let selectedClass = ""
#     if (props.selected.includes(card.id)) {
#       selectedClass = "card-selected"
#     }
#     let cardFunction
#     if (props.gemMode === false) {
#       cardFunction = props.handleSelectCard
#       if (card.gem && card.gem.id !== props.currentUser.id) {
#         cardFunction = props.handleGemmedCard
#       }
#     } else if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_two.push(<CardTile
#       key={card.id}
#       id={card.id}
#       which_card={card}
#       handleSelectCard={cardFunction}
#       selectedClass={selectedClass}
#       token={token}
#       type="card-in-game"
#       gem={card.gem}
#       currentUser={props.currentUser}
#       />)
#   } else {
#     let cardFunction = ""
#     if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_two.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem}
#     currentUser={props.currentUser}/>)
#   }
#   counter++
# })
# 
# counter = 0
# row_length = props.cards.row_three.length
# props.cards.row_three.forEach((card) => {
#   let isAdjacentCardSelected = false
#   if (props.cards.row_three.length > 1) {
#     if (card.id === props.cards.row_three[1].id && props.selected.includes(props.cards.row_three[0].id)) {
#       isAdjacentCardSelected = true
#     }
#     if (card.id === props.cards.row_three[props.cards.row_three.length - 2].id && props.selected.includes(props.cards.row_three[props.cards.row_three.length - 1].id)) {
#       isAdjacentCardSelected = true
#     }
#   }
# 
#   let token = card.token
#   if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
#     let selectedClass = ""
#     if (props.selected.includes(card.id)) {
#       selectedClass = "card-selected"
#     }
#     let cardFunction
#     if (props.gemMode === false) {
#       cardFunction = props.handleSelectCard
#       if (card.gem && card.gem.id !== props.currentUser.id) {
#         cardFunction = props.handleGemmedCard
#       }
#     } else if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_three.push(<CardTile
#       key={card.id}
#       id={card.id}
#       which_card={card}
#       handleSelectCard={cardFunction}
#       selectedClass={selectedClass}
#       token={token}
#       type="card-in-game"
#       gem={card.gem}
#       currentUser={props.currentUser}
#       />)
#   } else {
#     let cardFunction = ""
#     if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_three.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem}
#     currentUser={props.currentUser}/>)
#   }
#   counter++
# })
# 
# counter = 0
# row_length = props.cards.row_four.length
# props.cards.row_four.forEach((card) => {
#   let isAdjacentCardSelected = false
#   if (props.cards.row_four.length > 1) {
#     if (card.id === props.cards.row_four[1].id && props.selected.includes(props.cards.row_four[0].id)) {
#       isAdjacentCardSelected = true
#     }
#     if (card.id === props.cards.row_four[props.cards.row_four.length - 2].id && props.selected.includes(props.cards.row_four[props.cards.row_four.length - 1].id)) {
#       isAdjacentCardSelected = true
#     }
#   }
# 
#   let token = card.token
#   if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
#     let selectedClass = ""
#     if (props.selected.includes(card.id)) {
#       selectedClass = "card-selected"
#     }
#     let cardFunction
#     if (props.gemMode === false) {
#       cardFunction = props.handleSelectCard
#       if (card.gem && card.gem.id !== props.currentUser.id) {
#         cardFunction = props.handleGemmedCard
#       }
#     } else if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_four.push(<CardTile
#       key={card.id}
#       id={card.id}
#       which_card={card}
#       handleSelectCard={cardFunction}
#       selectedClass={selectedClass}
#       token={token}
#       type="card-in-game"
#       gem={card.gem}
#       currentUser={props.currentUser}
#       />)
#   } else {
#     let cardFunction = ""
#     if (props.gemMode === true) {
#       cardFunction = props.handleGemPlacement
#     }
#     row_four.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem}
#     currentUser={props.currentUser}/>)
#   }
#   counter++
# })



#CARD SELECTION: OLD CODE
# if cards["row_one"].any? { |find_card| find_card["id"] == card[:id]}
#   if cards["row_one"][0]["id"] == card[:id]
#     if cards["row_one"][0]["token"]
#       if cards["row_one"][0]["token"]["spirit"] == "plus-1" || cards["row_one"][0]["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_one"][0]["token"]
#     end
#     if cards["row_one"][0]["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_one"].shift
#   elsif cards["row_one"].last["id"] == card[:id]
#     if cards["row_one"].last["token"]
#       if cards["row_one"].last["token"]["spirit"] == "plus-1" || cards["row_one"].last["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_one"].last["token"]
#     end
#     if cards["row_one"].last["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_one"].pop
#   else
#     error = "Invalid selection"
#   end
# end
# 
# if cards["row_two"].any? { |find_card| find_card["id"] == card[:id]}
#   if cards["row_two"][0]["id"] == card[:id]
#     if cards["row_two"][0]["token"]
#       if cards["row_two"][0]["token"]["spirit"] == "plus-1" || cards["row_two"][0]["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_two"][0]["token"]
#     end
#     if cards["row_two"][0]["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_two"].shift
#   elsif cards["row_two"].last["id"] == card[:id]
#     if cards["row_two"].last["token"]
#       if cards["row_two"].last["token"]["spirit"] == "plus-1" || cards["row_two"].last["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_two"].last["token"]
#     end
#     if cards["row_two"].last["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_two"].pop
#   else
#     error = "Invalid selection"
#   end
# end
# 
# if cards["row_three"].any? { |find_card| find_card["id"] == card[:id]}
#   if cards["row_three"][0]["id"] == card[:id]
#     if cards["row_three"][0]["token"]
#       if cards["row_three"][0]["token"]["spirit"] == "plus-1" || cards["row_three"][0]["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_three"][0]["token"]
#     end
#     if cards["row_three"][0]["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_three"].shift
#   elsif cards["row_three"].last["id"] == card[:id]
#     if cards["row_three"].last["token"]
#       if cards["row_three"].last["token"]["spirit"] == "plus-1" || cards["row_three"].last["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_three"].last["token"]
#     end
#     if cards["row_three"].last["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_three"].pop
#   else
#     error = "Invalid selection"
#   end
# end
# 
# if cards["row_four"].any? { |find_card| find_card["id"] == card[:id]}
#   if cards["row_four"][0]["id"] == card[:id]
#     if cards["row_four"][0]["token"]
#       if cards["row_four"][0]["token"]["spirit"] == "plus-1" || cards["row_four"][0]["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_four"][0]["token"]
#     end
#     if cards["row_four"][0]["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_four"].shift
#   elsif cards["row_four"].last["id"] == card[:id]
#     if cards["row_four"].last["token"]
#       if cards["row_four"].last["token"]["spirit"] == "plus-1" || cards["row_four"].last["token"]["spirit"] == "plus-2"
#         current_match.gems_possessed += 1
#         current_match.gems_total += 1
#         current_match.save
#       end
#       tokens << cards["row_four"].last["token"]
#     end
#     if cards["row_four"].last["gem"]
#       current_match.gems_possessed += 1
#       current_match.save
#     end
#     cards["row_four"].pop
#   else
#     error = "Invalid selection"
#   end
# end



#OLD GEM PLACEMENT CODE

# ROW ONE

      # card_to_gem_index = current_game_gameState["row_one"].index{ |card| card["id"] == params["gemmedCard"] }
      # if current_game_gameState["row_one"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
      #   if current_game_gameState["row_one"][card_to_gem_index]["gem"]["id"] == user.id
      #     current_game_gameState["row_one"][card_to_gem_index].delete("gem")
      #     current_match.gems_possessed += 1
      #     current_match.save
      #   else
      #     #OPPONENT GEM LOGIC
      #     if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #       current_game_gameState["row_one"][card_to_gem_index].delete("gem")
      #       current_game.gem_placed = true
      #       current_game.save
      #       current_match.gems_possessed -= 1
      #       current_match.gems_total -= 1
      #       current_match.save
      #       opponent_match.gems_possessed += 1
      #       opponent_match.save
      #     elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #       error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #     else
      #       error_message = "You need to be holding a gem in order to remove your opponent's"
      #     end
      #   end
      # else #IF THE CARD DOES NOT HAVE A GEM
      #   if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #     card_to_gem_index = current_game_gameState["row_one"].index{ |card| card["id"] == params["gemmedCard"] }
      #     current_game_gameState["row_one"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
      #     current_game.gem_placed = true
      #     current_game.save
      #     current_match.gems_possessed -= 1
      #     current_match.save
      #   elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #     error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #   else
      #     error_message = "You don't have any gems left to place!"
      #   end
      # end


# ROW TWO

      #   card_to_gem_index = current_game_gameState["row_two"].index{ |card| card["id"] == params["gemmedCard"] }
      #   if current_game_gameState["row_two"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
      #     if current_game_gameState["row_two"][card_to_gem_index]["gem"]["id"] == user.id
      #       current_game_gameState["row_two"][card_to_gem_index].delete("gem")
      #       current_match.gems_possessed += 1
      #       current_match.save
      #     else
      #       #OPPONENT GEM LOGIC
      #       if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #         current_game_gameState["row_two"][card_to_gem_index].delete("gem")
      #         current_game.gem_placed = true
      #         current_game.save
      #         current_match.gems_possessed -= 1
      #         current_match.gems_total -= 1
      #         current_match.save
      #         opponent_match.gems_possessed += 1
      #         opponent_match.save
      #       elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #         error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #       else
      #         error_message = "You need to be holding a gem in order to remove your opponent's"
      #       end
      #     end
      #   else #IF THE CARD DOES NOT HAVE A GEM
      #     if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #       card_to_gem_index = current_game_gameState["row_two"].index{ |card| card["id"] == params["gemmedCard"] }
      #       current_game_gameState["row_two"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
      #       current_game.gem_placed = true
      #       current_game.save
      #       current_match.gems_possessed -= 1
      #       current_match.save
      #     elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #       error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #     else
      #       error_message = "You don't have any gems left to place!"
      #     end
      #   end
      # 

# ROW THREE
      #   card_to_gem_index = current_game_gameState["row_three"].index{ |card| card["id"] == params["gemmedCard"] }
      #   if current_game_gameState["row_three"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
      #     if current_game_gameState["row_three"][card_to_gem_index]["gem"]["id"] == user.id
      #       current_game_gameState["row_three"][card_to_gem_index].delete("gem")
      #       current_match.gems_possessed += 1
      #       current_match.save
      #     else
      #       #OPPONENT GEM LOGIC
      #       if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #         current_game_gameState["row_three"][card_to_gem_index].delete("gem")
      #         current_game.gem_placed = true
      #         current_game.save
      #         current_match.gems_possessed -= 1
      #         current_match.gems_total -= 1
      #         current_match.save
      #         opponent_match.gems_possessed += 1
      #         opponent_match.save
      #       elsif current_match.gems_possessed && current_game.gem_placed == true
      #         error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #       else
      #         error_message = "You need to be holding a gem in order to remove your opponent's"
      #       end
      #     end
      #   else #IF THE CARD DOES NOT HAVE A GEM
      #     if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #       card_to_gem_index = current_game_gameState["row_three"].index{ |card| card["id"] == params["gemmedCard"] }
      #       current_game_gameState["row_three"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
      #       current_game.gem_placed = true
      #       current_game.save
      #       current_match.gems_possessed -= 1
      #       current_match.save
      #     elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #       error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #     else
      #       error_message = "You don't have any gems left to place!"
      #     end
      #   end
      # 


# ROW FOUR

      # card_to_gem_index = current_game_gameState["row_four"].index{ |card| card["id"] == params["gemmedCard"] }
      #   if current_game_gameState["row_four"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
      #     if current_game_gameState["row_four"][card_to_gem_index]["gem"]["id"] == user.id
      #       current_game_gameState["row_four"][card_to_gem_index].delete("gem")
      #       current_match.gems_possessed += 1
      #       current_match.save
      #     else
      #       #OPPONENT GEM LOGIC
      #       if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #         current_game_gameState["row_four"][card_to_gem_index].delete("gem")
      #         current_game.gem_placed = true
      #         current_game.save
      #         current_match.gems_possessed -= 1
      #         current_match.gems_total -= 1
      #         current_match.save
      #         opponent_match.gems_possessed += 1
      #         opponent_match.save
      #       elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #         error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #       else
      #         error_message = "You need to be holding a gem in order to remove your opponent's"
      #       end
      #     end
      #   else #IF THE CARD DOES NOT HAVE A GEM
      #     if current_match.gems_possessed > 0 && current_game.gem_placed == false
      #       card_to_gem_index = current_game_gameState["row_four"].index{ |card| card["id"] == params["gemmedCard"] }
      #       current_game_gameState["row_four"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
      #       current_game.gem_placed = true
      #       current_game.save
      #       current_match.gems_possessed -= 1
      #       current_match.save
      #     elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
      #       error_message = "You have already placed a gem this turn. Either click a gem to remove it, or click 'Pick Cards' to switch back to card selection."
      #     else
      #       error_message = "You don't have any gems left to place!"
      #     end
      #   end
