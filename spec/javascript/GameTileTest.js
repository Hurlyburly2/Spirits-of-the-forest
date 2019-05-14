import GameTile from '../../app/javascript/react/components/GameTile'

describe('GameTile', () => {
  let wrapper,
    id,
    opponent,
    onClick,
    current_player={
      created_at: "2019-05-04T01:37:38.736Z",
      email: "email@email.com",
      id: 1,
      losses: 72,
      rank: "silver",
      rankup_score: 170,
      reminders: true,
      updated_at: "2019-05-13T20:13:11.969Z",
      username: "Gmail",
      which_profile_pic: 2,
      wins: 37
    };
    
  beforeEach(() => {
    onClick = jasmine.createSpy('onClick spy')
    wrapper = mount(
      <GameTile
        id="1"
        current_player={current_player}
        opponent="Waiting for Opponent"
        handleClickTile={onClick}
      />
    )
  })
  it('should render with the correct text', () => {
    expect(wrapper.find('span').text()).toBe('Waiting for Opponent')
  })
  
  it('should render with a link', () => {
    expect(wrapper.find('a')).toBePresent();
  })
})


// key={game.id}
// id={game.id}
// current_player={this.state.currentUser}
// opponent={opponent}
// opponentPic={opponentPic}
// opponentRank={opponentRank}
// clickable={true}
// whose_turn={game.whose_turn_id}
